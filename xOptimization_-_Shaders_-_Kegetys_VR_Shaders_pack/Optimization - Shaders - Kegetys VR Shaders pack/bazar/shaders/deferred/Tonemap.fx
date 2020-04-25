#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/deferredCommon.hlsl"
#include "deferred/colorGrading.hlsl"
// #define PLOT_TONEMAP_FUNCION
// #define PLOT_AVERAGE_LUMINANCE
// #define PLOT_HISTOGRAM
// #define DRAW_FOCUS
#include "deferred/toneMap.hlsl"
#include "deferred/calcAvgLum.hlsl"
#include "common/random.hlsl"

#include "_HMD.hlsl"


Texture2D<float4> bloomTexture;//итоговый блум

Texture3D colorGradingLUT;

float2	srcDims;
float	accumOpacity;

static const float3 NVD_SENSOR = { 1.0, 0.1, 0.1 };
float3 nvdColor;

struct VS_OUTPUT {
	noperspective float4 pos	:SV_POSITION0;
	noperspective float4 projPos:TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID)
{
	const float2 quad[4] = {
		{-1, -1}, {1, -1},
		{-1,  1}, {1,  1}
	};
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos.xy = float2(o.pos.x, -o.pos.y) * 0.5 + 0.5;
	o.projPos.zw = o.projPos.xy * dcViewport.zw + dcViewport.xy;
	return o;
}

float Vignette(float2 uv, float q, float o) {
	//q = 0.65, o = 3.0
	float x = saturate(1 - distance(uv, 0.5) * q);
	return ( log( (o - 1.0/exp(o)) * x + 1.0/exp(o) ) + o ) / (log(o) + o);
}

float Vignette2(float2 uv, float q, float o) {
	uv *=  1.0 - uv.yx;
	float vig = uv.x * uv.y * 16.0;
	return pow(max(0, vig), o) * q + (1 - q);
}

float3 ColorGrade(float3 sourceColor, uint2 uv)
{
	// return sourceColor;
	return colorGradingLUT.SampleLevel(gTrilinearClampSampler, sourceColor*15.0/16.0 + 0.5/16.0, 0).rgb;
	// return ColorGrade_Cinecolor(sourceColor, float3(1, 0, 0));
	// return ColorGrade_Cinecolor(sourceColor, float3(1, 0.447, 0));
	// return ColorGrade_Technicolor_1(sourceColor);
	// return ColorGrade_Technicolor_2(sourceColor);
	// return ColorGrade_Technicolor_ThreeStrip(sourceColor, float3(1,0,0));
	// return ColorGrade_CGA(sourceColor, uv);
	// return ColorGrade_EGA(sourceColor, uv);
}

float3 dither(in float2 uv, in float3 s)
{
	return 1.0 - (((uv.x % 2.0 * (2.0 / 3.0)) + (uv.y % 2.0 * (1.0 / 3.0)) - 0.5) * s);
}

float3 ToneMapSample(const VS_OUTPUT i, uint idx, uniform int tonemapOperator, uniform int flags = 0)
{
	uint2 uv = i.pos.xy;
	
	const uint pixelSize = 1;

	float3 sceneColor = SampleMap(ComposedMap, uv - (pixelSize>1 ? fmod(uv, pixelSize):0), idx).xyz;

#if ENABLE_NO_BLOOM
	float3 bloom = 0;
#else
	float3 bloom = bloomTexture.SampleLevel(gBilinearClampSampler, i.projPos.zw, 0).rgb;
#endif

	float exposure = getLinearExposure(getAvgLuminanceClamped());
#if NVG_GAIN_ADJUSTS_POSITION
  if (flags & TONEMAP_FLAG_NVD)
    exposure = 1;
#endif  
	float3 linearColor = lerp(sceneColor, bloom, bloomLerpFactor) * exposure;
	
#if ENABLE_DITHERING
  linearColor *= dither(uv, float3(0.02, 0.025, 0.04));
#endif
	
	if(flags & TONEMAP_FLAG_WHITE_BALANCE)
	{
		linearColor /= lerp(1, AmbientWhitePoint, whiteBalanceFactor);
	}
	
	if(flags & TONEMAP_FLAG_VIGNETTE)
	{
		linearColor *= Vignette2(i.pos.xy / gSreenParams.xy, 0.35, 0.15);
	}
	
	//HDR -> LDR -> screen gamma space
	float3 screenColor;
	if (flags & TONEMAP_FLAG_NVD) {
		linearColor = dot(linearColor, NVD_SENSOR) * nvdColor;
		screenColor = LinearToScreenSpace(toneMap(linearColor, TONEMAP_OPERATOR_EXPONENTIAL));
	} else {
		screenColor = LinearToScreenSpace(toneMap(linearColor, tonemapOperator));
	}

#if ENABLE_NO_BLOOM
	if(flags & TONEMAP_FLAG_COLOR_GRADING)
	{
		// float3 whitePoint = bloomTexture.SampleLevel(gBilinearClampSampler, float2(0,0), 20).rgb;
		// whitePoint *= 3.0 / (whitePoint.r+whitePoint.g+whitePoint.b);
		// screenColor = bloomTexture[i.pos.xy].rgb / lerp(1, whitePoint, whiteBalanceFactor);
		float gradingFactor = 1.0;
		screenColor = lerp(screenColor, ColorGrade(screenColor, uv/pixelSize), gradingFactor);
	}
#endif
	
	debugDraw(i.projPos.xy, uv, screenColor);
	
#ifdef DRAW_FOCUS
	return calcGaussianWeight(length(i.projPos.xy*2-1) * focusWidth, focusSigma);
#endif
	
	return screenColor;
}

float3 SimpleToneMapSample(const VS_OUTPUT i, uint idx) {
	return simpleToneMap(SampleMap(ComposedMap, i.pos.xy, idx).xyz);
}

float4 PS_DebugToneMap(const VS_OUTPUT i, uint idx: SV_SampleIndex): SV_TARGET0 {
	uint2 uv = i.pos.xy;
	return SampleMap(ComposedMap, uv, idx).rgba;
}

float4 PS_ToneMap(const VS_OUTPUT i, uint sidx: SV_SampleIndex, uniform int tonemapOperator, uniform int flags = 0): SV_TARGET0
{
	return float4(ToneMapSample(i, sidx, tonemapOperator, flags), 1);
}

float4 PS_SimpleToneMap(const VS_OUTPUT i, uint sidx: SV_SampleIndex): SV_TARGET0 {	// without bloom
	return float4(SimpleToneMapSample(i, sidx), 1);
}


VertexShader vsComp = CompileShader(vs_5_0, VS());

#define PASS_BODY(ps) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}
	
#define PASS_NAME(prefix, suffix) prefix##suffix

#define TONEMAP_OPERATOR_VARIANTS(name, operatorId) \
	pass PASS_NAME(name, 0)			PASS_BODY(PS_ToneMap(operatorId, 0))\
	pass PASS_NAME(name, 1)			PASS_BODY(PS_ToneMap(operatorId, 1))\
	pass PASS_NAME(name, 2)			PASS_BODY(PS_ToneMap(operatorId, 2))\
	pass PASS_NAME(name, 3)			PASS_BODY(PS_ToneMap(operatorId, 3))\
	pass PASS_NAME(name, 4)			PASS_BODY(PS_ToneMap(operatorId, 4))\
	pass PASS_NAME(name, 5)			PASS_BODY(PS_ToneMap(operatorId, 5))\
	pass PASS_NAME(name, 6)			PASS_BODY(PS_ToneMap(operatorId, 6))\
	pass PASS_NAME(name, 7)			PASS_BODY(PS_ToneMap(operatorId, 7))


technique10 ToneMap {
	TONEMAP_OPERATOR_VARIANTS(Linear,		TONEMAP_OPERATOR_LINEAR)
	TONEMAP_OPERATOR_VARIANTS(Exponential,	TONEMAP_OPERATOR_EXPONENTIAL)
	TONEMAP_OPERATOR_VARIANTS(Filmic,		TONEMAP_OPERATOR_FILMIC)
	
	pass NVG					PASS_BODY(PS_ToneMap(TONEMAP_OPERATOR_EXPONENTIAL, TONEMAP_FLAG_NVD))
	pass Debug					PASS_BODY(PS_DebugToneMap())
}

technique10 SimpleToneMap {
	pass TM						PASS_BODY(PS_SimpleToneMap())
}

technique10 LuminanceMap {
	pass luminanceBySinglePass			{ SetComputeShader(CompileShader(cs_5_0, CS_Lum(LUMINANCE_ONE_PASS)));	}
	pass fromScreenToLumTarget			{ SetComputeShader(CompileShader(cs_5_0, CS_Lum(LUMINANCE_PASS_0)));	}
	pass fromLumTargetToStructBuffer	{ SetComputeShader(CompileShader(cs_5_0, CS_Lum(LUMINANCE_PASS_1))); 	}
}

technique10 Adaptation {
	pass averageLuminanceForAllViewports {
		SetComputeShader(CompileShader(cs_5_0, CS_Adaptation(true)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
	pass useLuminanceOfProvidedViewport {
		SetComputeShader(CompileShader(cs_5_0, CS_Adaptation(false)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}
