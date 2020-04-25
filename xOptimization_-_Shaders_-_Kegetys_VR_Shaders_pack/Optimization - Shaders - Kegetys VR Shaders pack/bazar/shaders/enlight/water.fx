
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/GBuffer.hlsl"
#include "noise/noise2D.hlsl"
#include "noise/noise3D.hlsl"
#include "noise/worley.hlsl"

#include "enlight/shadows.hlsl"

Texture2D g_WaveTexture;
Texture2D g_MaskTexture;

#define USE_MASK 1
#define USE_FFT_FOAM 1
#define USE_SHALLOW_FOAM 0
#define USE_SURF 0
#define USE_SURF_FOAM 0
#define USE_BOTTOM_SHADOW 1

#define USE_NOISE_COAST 1
#define USE_PS_MASK_DISCARD 0

#define SHOW_NORMAL 0
#define USE_REFLECTION_TEST 0

static float	g_DynamicTessFactor = 64;

#include "enlight/waterCommon.hlsl"

#ifdef MSAA
	Texture2DMS<float, MSAA> g_MainDepthTexture;	// need to build river mask -> waterMask.g
	Texture2DMS<uint2, MSAA> g_StencilTexture;
	float LoadDepth(uint2 uv) { return g_MainDepthTexture.Load(uv, 0).r; }
	uint  LoadStencil(uint2 uv) { return g_StencilTexture.Load(uv, 0).g; }
#else
	Texture2D<float> g_MainDepthTexture;
	Texture2D<uint2> g_StencilTexture;
	float LoadDepth(uint2 uv) { return g_MainDepthTexture.Load(uint3(uv, 0)).r; }
	uint  LoadStencil(uint2 uv) { return g_StencilTexture.Load(uint3(uv, 0)).g; }
#endif

struct DUMMY {
	float Dummmy : DUMMY;
};

struct VS_OUTPUT {
    float2 pos   : POSITION;
};

struct PatchData {
	float2 pos   : POSITION;

	float Edges[4]  : SV_TessFactor;
    float Inside[2]	: SV_InsideTessFactor;
};

struct DS_OUTPUT {
    float4 position:		SV_POSITION;
    float4 projPos:			TEXCOORD0;
    float3 positionWS:		TEXCOORD1;
};

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

VS_OUTPUT VS(float2 pos: POSITION) {
	VS_OUTPUT o;
	o.pos = pos*g_Scale.x;
	return o;
}

bool isWater(uint materialID) {
	return (materialID & STENCIL_COMPOSITION_MASK) == STENCIL_COMPOSITION_WATER;
}

float4 getWave(out float foam, float2 uv, uniform bool checkDiscard) {
	float4 wave = g_WaveTexture.SampleLevel(SamplerLinearClamp, uv, 0);

#if USE_PS_MASK_DISCARD
	if (checkDiscard) {
		if (!any(wave.xyz))
			discard;
	}
#endif

	foam = wave.w;
#if SHOW_NORMAL
	return wave;
#endif
	wave.xy = (wave.xy-127.0/255)*2; // xz of normal
	float ny = sqrt(1 - wave.x*wave.x - wave.y*wave.y);
	return float4(wave.x, ny, wave.y, wave.z-0.5);
}

float3 getWaveDisplace(float2 uv) {
	float foam;
	float4 nw = getWave(foam, uv, false);
	return nw.xyz*(nw.w * 10);
}

float3 addNormal(float3 normal1, float3 normal2) {
	float3x3 mat;
	mat[1] = normal1;
	mat[2] = normalize(cross(float3(1.0,0.0,0.0),mat[1]));
	mat[0] = cross(mat[1], mat[2]);
	return mul(normal2, mat);
}

float CalculateTessellationFactor(float distance) {
	return max(1, exp(-distance*0.005)*g_Scale.x*g_DynamicTessFactor);
}

void applyWaveNormal(out float foam, float3 world_position, in out float3 result, in out float wLevel) {
	float4 pp = mul(float4(world_position-g_Offset, 1.0), gViewProj);
	float2 uv = float2(pp.x/pp.w*0.5+0.5, 0.5-pp.y/pp.w*0.5);

	float4 nw = getWave(foam, uv, true);
	float displaceY = nw.y*(nw.w * 10);

	result = addNormal(normalize(result), nw.xyz);
//	result = normalize(normalize(result) + nw.xyz);
	wLevel = saturate(((wLevel-0.5)*8 + displaceY)*0.125 + 0.5);	// repack wLevel
}

// constructing the displacement amount and normal for water surface geometry
float4 CombineWaterCommon(float3 world_position, float tilingMask, uniform bool useTilingMask, uniform bool calcNormal, uniform bool useFoamFFT) {
	float4 result;

	if (useTilingMask) {
		float3 tiling = (1 + tilingMask * 3)*float3(1.0, 0.9, 1.1);
		int3 e = log2(tiling);
		int3 scale = (1 << e);

		float4 r0 = combineWaterNormal(world_position, scale[2], calcNormal, useFoamFFT ? scale[0] & 1 : false);
		float4 r1 = combineWaterNormal(world_position, 2 * scale[1], calcNormal, 0);
		float factor = (tiling[0] - scale[0]) / float(scale[0]);
		result = lerp(r0, r1, factor);
	}
	else {
		result = combineWaterNormal(world_position, 1, calcNormal, useFoamFFT);
	}
	return result;
}

float3 CombineWaterDisplace(float3 world_position, float tilingMask, uniform bool useTilingMask) {
	return CombineWaterCommon(world_position, tilingMask, useTilingMask, false, false).xyz;
}

float3 CombineWaterNormal(out float foam, out float wLevel, float3 world_position, float fadeMask, float tilingMask, uniform bool useTilingMask, uniform bool useFoamFFT) {
	float4 result = CombineWaterCommon(world_position, tilingMask, useTilingMask, true, useFoamFFT);

	wLevel = result.z;
	result.xyz = restoreNormal(result.xy);

	applyWaveNormal(foam, world_position, result.xyz, wLevel);
	if (useFoamFFT) {	// calculate foam
		float2 p = (world_position.xz - g_Offset.xz + gOrigin.xz) / 64;
		float n = snoise(float3(p, g_Time*0.05))+0.7;

//		foam += n;
		foam += saturate(result.w * 2 * n);
	}

	return result.xyz;
}

static const float2 tileTessOffs[4] = {
	float2(0, 0.5), float2(0.5, 0),
	float2(1, 0.5),	float2(0.5, 1),
};

PatchData PatchConstantHS( InputPatch<VS_OUTPUT, 1> inputPatch ) {    

    PatchData output;

	float inside_tessellation_factor=0;
	bool in_frustum = true;

	output.pos = inputPatch[0].pos;


	float3 sum = 0;
	[unroll]
	for (uint i = 0; i < 4; ++i) {
		float2 pos = output.pos + (g_TileSize*(quad[i] + 1) * 0.5);
		float4 p = mul(float4(float3(pos.x, g_Level, pos.y) - g_Offset, 1), gViewProj);
#if USE_CLIP_TEST
		p.xy *= 1.5;
#endif
		p.xyz /= p.w;
		sum += float3(clamp(p.xy*0.8, -1, 1), clamp(p.z * 2 - 1, -1, 1));		// culling -1<XY<1, 0<Z<1, 0.8 - margin for possible displace vertex
	}

//	in_frustum = abs(sum.x) < 4 && abs(sum.y) < 4 && abs(sum.z) < 4;
	in_frustum = !any(step(4, abs(sum)));
//	in_frustum = !any(step(3, abs(sum.xy)));	// test

	if(in_frustum) {	
		[unroll]
		for (uint i = 0; i < 4; ++i) {
			float distance_to_camera = length(gCameraPos.xz - (output.pos - g_Offset.xz + g_TileSize*tileTessOffs[i]));
			float tesselation_factor = CalculateTessellationFactor(distance_to_camera);
			output.Edges[i] = tesselation_factor;
			inside_tessellation_factor += tesselation_factor;
		}
		output.Inside[0] = output.Inside[1] = inside_tessellation_factor;// *0.25;
	} else {
		output.Edges[0]=output.Edges[1]=output.Edges[2]=output.Edges[3]=-1;
		output.Inside[0]=output.Inside[1]=-1;
	}

    return output;
}

float noiseCoast(float2 wposXZ) {
	return snoise((wposXZ + gOrigin.xz)*0.01)*0.2;
}

[domain("quad")]
[partitioning("fractional_odd")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PatchConstantHS")]
DUMMY HS( InputPatch<VS_OUTPUT, 1> inputPatch ) {  return (DUMMY)0; }

[domain("quad")]
DS_OUTPUT DS(PatchData input, float2 uv : SV_DomainLocation, OutputPatch<DUMMY, 1> inputPatch, uniform bool useTilingMask)
{
    DS_OUTPUT output;
	float3 vertexPosition;
	float3 water_displace;
	
	// calculating water surface geometry position and normal
	vertexPosition.xz = input.pos + uv * g_TileSize;
	vertexPosition.y = g_Level;

	float4 pp = mul(float4(vertexPosition.xyz - g_Offset, 1.0), gViewProj);
	float2 tuv = float2(pp.x / pp.w*0.5 + 0.5, 0.5 - pp.y / pp.w*0.5);

	float4 mask = g_MaskTexture.SampleLevel(SamplerLinearClamp, tuv, 0);

	if (useTilingMask) {
		float tilingMask = mask.r;
		water_displace = CombineWaterDisplace(vertexPosition.xyz, tilingMask, true).xyz;
	} else {
		water_displace = CombineWaterDisplace(vertexPosition.xyz, 0, false).xyz;
	}

	vertexPosition -= g_Offset;

	float d = distance(vertexPosition, gCameraPos);

	float deepMask = mask.z*(1 - mask.y);	
	float deep = (deepMask - 127.0 / 255.0)*20.0 - 0.5;	 

	float3 wave_displace = getWaveDisplace(tuv);

#if USE_NOISE_COAST
	wave_displace += noiseCoast(vertexPosition.xz);
#endif

	deep += wave_displace.y;
	water_displace.y = deep > 0 ? max(water_displace.y, -deep) : 0;

	float sm = abs(sigmoid(deep, 0.1));	// abs of sigmoid
	water_displace.y *= sm;

	water_displace += wave_displace;

	//	water_displace *= exp(-d*0.0005);
	water_displace *= max(0, 0.5 - d / (d + 2000)) * 2;

	vertexPosition += water_displace;

	// writing output params
	output.positionWS = vertexPosition;
	output.position = output.projPos = mul(float4(vertexPosition, 1.0), gViewProj);
    return output;
}

float calcFoamTexture(float2 pos, float vol, uniform uint samples) {
	vol = saturate(vol);
	vol *= 0.6;
	float result = 0;
	float t = g_Time * 0.2;
	[unroll]
	for (uint i = 0; i < samples; ++i) {
		uint m = 1 << i;
		float s = snoise(float3(pos, t)*m);
//		result += vol - abs(s) * 1.0 / (m*0.5 + 0.5);
		result += vol - abs(s) * 1.0 / m;
	}
	return saturate(result);
}

GBuffer PS(DS_OUTPUT input, uniform bool useFoamFFT, uniform bool useTilingMask) {

	float3 wpos = input.positionWS + g_Offset;
	float2 uv = float2(input.projPos.x, -input.projPos.y) / input.projPos.w*0.5 + 0.5;

	float4 mask = float4(0, 0, 0, 0);
#if USE_MASK
	mask = g_MaskTexture.SampleLevel(SamplerLinearClamp, uv, 0);
#endif

//	return BuildGBufferWater(float4(0,0,0, 1), float3(0,1,0), 0, x, input.projPos, 1);

	float3 normal;
	float foam, wLevel;
	if (useTilingMask) {
		normal = CombineWaterNormal(foam, wLevel, wpos, 0, mask.r, true, useFoamFFT);
	} else {
		normal = CombineWaterNormal(foam, wLevel, wpos, 0, 0, false, useFoamFFT);
	}

	float alpha = 1 - mask.g;
	alpha *= alpha;

	float deepFactor, bottomNoL;
	float water_depth = calcWaterDepth(input.positionWS, uv);
	float3 color = waterColorDS(normal, input.positionWS, uv, deepFactor, bottomNoL, 0, water_depth);

	float2 p = input.positionWS.xz + gOrigin.xz;
	float d = distance(input.positionWS, gCameraPos);
	foam = lerp(calcFoamTexture(p*0.25, foam, 3), foam*foam*foam, sigmoid(d, 500));

	return BuildGBufferWater(float4(color, alpha), normal, wLevel, foam, deepFactor, bottomNoL, input.projPos, 0);
}


///////////////////////////////////////////////////////////////////////////// LOW

PatchData PatchConstantHS_LOW( InputPatch<VS_OUTPUT, 1> inputPatch ) {    
    PatchData output;
	output.pos = inputPatch[0].pos;
	output.Edges[0] = output.Edges[1] = output.Edges[2] = output.Edges[3] = output.Inside[0] = output.Inside[1] = 1;
    return output;
}

[domain("quad")]
[partitioning("fractional_odd")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PatchConstantHS_LOW")]
DUMMY HS_LOW( InputPatch<VS_OUTPUT, 1> inputPatch ) {  return (DUMMY)0; }

DS_OUTPUT DS_VS_LOW(float2 pos) {
    DS_OUTPUT output;

	float3 vertexPosition;

	// calculating water surface geometry position and normal
	vertexPosition.xz = pos;
	vertexPosition.y  = g_Level;
	vertexPosition -= g_Offset;

	output.positionWS = vertexPosition;
	output.position = output.projPos = mul(float4(vertexPosition, 1.0), gViewProj);

	return output;
}

[domain("quad")]
DS_OUTPUT DS_LOW(PatchData input, float2 uv : SV_DomainLocation, OutputPatch<DUMMY, 1> inputPatch ) {
	return DS_VS_LOW(input.pos + uv * g_TileSize);
}

DS_OUTPUT VS_FLAT(float2 pos: POSITION) {
	return DS_VS_LOW(pos*g_Scale.x);
}

float4 PS_DRAFT(DS_OUTPUT i) : SV_TARGET0 {
	float3 normal = restoreNormal( combineWaterNormal(i.positionWS + g_Offset, 1, true, false).xy );
	float3 color = waterColorDraft(normal, i.positionWS);
	color = applyAtmosphereLinear(gCameraPos.xyz, i.positionWS, i.projPos, color, normal);
	return float4(color, 1);
}

float4 PS_FLIR(DS_OUTPUT i) : SV_TARGET0 {
	float3 normal = restoreNormal(combineWaterNormal(i.positionWS + g_Offset, 1, true, false).xy);
	return float4(waterColorFLIR(normal, i.positionWS), 1);
}

float4 PS_RADAR(DS_OUTPUT i) : SV_TARGET0 {
	return float4(0,0,0,1);
}

///////////////////////// waves

struct VS_OUTPUT_SS {
	float4 pos:			SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_OUTPUT_SS VS_SS(uint vid: SV_VertexID) {
	VS_OUTPUT_SS o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos = o.pos.xy;
	return o;
}

struct PS_OUTPUT {
	float4 sv_target0 : SV_TARGET0;
	float4 sv_target1 : SV_TARGET1;
};

#define PIx2 6.283185307179586476925286766559

bool isModel(uint materialID) {
	materialID &= STENCIL_COMPOSITION_MASK;
	return (materialID == STENCIL_COMPOSITION_MODEL) || (materialID == STENCIL_COMPOSITION_COCKPIT);
}

bool isSurface(uint materialID) {
	materialID &= STENCIL_COMPOSITION_MASK;
	return materialID == STENCIL_COMPOSITION_SURFACE;
}

float4 buildMask(float2 uv, float2 projPos) {
	float depth = LoadDepth(uv);	// load depth from current depth, not copy!
	float4 d = mul(float4(projPos.xy, depth, 1), gViewProjInv);
	uint matID = LoadStencil(uv);

#if TILING_MASK_CHECKER
	float tilingMask = testTilingMaskBlur(d.xz / d.w + gOrigin.xz);
#else
	float tilingMask = 0;
#endif

	float2 mask = riverWaterMask(d.y / d.w);

	return float4(tilingMask, isWater(matID)*mask.x, max(mask.y, isModel(matID)), 1);
}

float3 waveDeep(float2 projPos) {
	float depth = LoadDepthBuffer(transformColorBuffer(projPos));
	float4 d = mul(float4(projPos.xy, depth, 1), gViewProjInv);
	return d.xyz / d.w;
}

float3 surfWave(float3 x) {
	x = max(x, 0);
	return max(x*exp(-x) - 0.025, 0);
//	return max(sin(x*0.25)*exp(-x)*5, 0);
//	return max(sin(x) / (abs(x) + 0.2), 0);
}

float noiseWave(float3 pos) {
	return 0.25 - worley((pos.xz + gOrigin.xz)*0.01, 2);
}

float4 waveFunc(float3 water_depth, float windFactor) {
	float p = 1 + 5*(windFactor + 0.3);

	float t = g_Time * 0.33;
	float ts = sin(t);
	float a = max(0, sin(t + 1) + 0.8) *(1.0 / 1.8);

	float3 x = water_depth * 5 + p * (ts - 1);
	float3 wave = surfWave(x);

	float fw = max(1, 6 - windFactor * 10);
	float fa = 7 + windFactor * 3;
	float foam = surfWave(x*fw).x*a*fa;

	wave.xyz *= max(0, windFactor + 0.2) * 10 * a;
	return float4(wave, foam);
}

float waterDeepByMask(float2 projPosXY) {
	return (g_MaskTexture.SampleLevel(SamplerLinearClamp, float2(projPosXY.x, -projPosXY.y) * 0.5 + 0.5, 0).z - 127.0 / 255) * 20.0;
}

float limitFactor(float x, float lim, float slope) {
	float f = -(x - lim) * slope;
	return max(0, f / (1 + abs(f)));
}

float4 buildWave(float3 p0, float3 p1, float3 waterDeep, float waterDeepFoam, uniform bool useFoam) {

#if USE_SURF
	float noise = noiseWave(p0);
	waterDeep += noise;

	float slopeFactor = max(abs(waterDeep.y - waterDeep.x), abs(waterDeep.z - waterDeep.x));
	float fc = limitFactor(slopeFactor, 0.025, 20);		// fade steep bank
	fc *= step(1e-9, slopeFactor);						// fade on absolutely flat shelf like in StraitOfDover, produce artifact like fingerprint on surf foam, only in PS_WAVE

	float windFactor = saturate((g_WindForce - 6.4)*(1.0 / (22.0 - 6.4))); // normalized windfactor

	float4 wave = waveFunc(waterDeep, windFactor)*fc;

	float2 bnormal = p1.xz - p0.xz;
	float3 w1 = float3(-bnormal.y, wave[2] - wave[0], bnormal.x);
	float3 w2 = float3(bnormal.x, wave[1] - wave[0], bnormal.y);
	float3 wnorm = normalize(cross(w1, w2));			// normal of wave

	float dist = distance(p0, gCameraPos);

	float foam = 0;

	if (useFoam) {
#if USE_SHALLOW_FOAM
#if USE_NOISE_COAST
		waterDeepFoam += max(0, noiseCoast(p0.xz));
#endif
		//	foam = max(foam, max(0, 1 - waterDeepFoam / (1 + windFactor))*sigmoid(windFactor, 0.1));
		foam = max(foam, max(0, (1 - waterDeepFoam) * exp(-dist * 0.001)));
#endif

#if USE_SURF_FOAM
		float fn = saturate((noise + 0.25)*5.0);
		foam = max(foam, wave.w*fn);
#endif
	}

	float fade = 1 - exp(-dist * 0.0001);
	return lerp(float4(wnorm.xz*0.5 + 127.0 / 255, wave[0] * 0.5 + 0.5, foam), float4(127.0 / 255, 127.0 / 255, 127.0 / 255, 0), fade);
#else
	return float4(127.0 / 255, 127.0 / 255, 127.0 / 255, 0);
#endif
}

float3 _projOnWaterLevel(float2 projPosXY) {
	float4 d = mul(float4(projPosXY, 0, 1), gViewProjInv);
	float3 dir = d.xyz / d.w - gCameraPos;
	return gCameraPos + dir * ( ((g_Level - gOrigin.y) - gCameraPos.y) / dir.y );
}

float4 PS_WAVE(VS_OUTPUT_SS i): SV_TARGET0 {

	float3 p0 = _projOnWaterLevel(i.projPos.xy);
	float3 p1 = _projOnWaterLevel(i.projPos.xy - float2(0, 2.0 / g_ColorBufferSize.y));

	float3 waterDeep = float3(waterDeepByMask(i.projPos.xy),
							  waterDeepByMask(i.projPos.xy + float2(2.0 / g_ColorBufferSize.x, 0)),
							  waterDeepByMask(i.projPos.xy - float2(0, 2.0 / g_ColorBufferSize.y)) );

	return buildWave(p0, p1, waterDeep, waterDeep.x, true);
}

PS_OUTPUT PS_WAVE_MASK(VS_OUTPUT_SS i) {

	float4 d = mul(float4(i.projPos.xy, 1, 1), gViewProjInv);
	float3 dir = d.xyz / d.w - gCameraPos;
	dir = normalize(dir);

	uint2 tuv = transformColorBuffer(i.projPos);
	float depth = LoadDepthBuffer(tuv);

	d = mul(float4(i.projPos.xy, depth, 1), gProjInv);

	float dist = d.z / d.w;
	d = mul(float4(i.projPos.xy, depth, 1), gViewProjInv);

	float waterDeep0 = -(d.y / d.w + gOrigin.y - g_Level);

	float3 p0 = d.xyz / d.w;

	float3 water1 = waveDeep(i.projPos.xy + float2(2.0 / g_ColorBufferSize.x, 0));
	float3 water2 = waveDeep(i.projPos.xy - float2(0, 2.0 / g_ColorBufferSize.y));

	float waterDeep1 = -(water1.y + gOrigin.y - g_Level);
	float waterDeep2 = -(water2.y + gOrigin.y - g_Level);

	PS_OUTPUT o;

	float modelDeep = isModel(LoadStencil(tuv)) * 10;

	o.sv_target0 = buildWave(p0, water2, max(float3(waterDeep0, waterDeep1, waterDeep2), modelDeep), max(waterDeep0, modelDeep), false);
	o.sv_target1 = buildMask(tuv, i.projPos);

//	o.sv_target0 = float4(127.0 / 255, 127.0 / 255, 127.0 / 255, 0);
//	o.sv_target1 = lerp(buildMask(tuv, i.projPos), float4(0, 0, 1, 0), fade);

	return o;
}

PS_OUTPUT PS_REFRACTION(VS_OUTPUT_SS i, uniform bool useMask)  {
	uint2 tuv = transformColorBuffer(i.projPos);
	float3 color = LoadColorBuffer(tuv);

	float depth = LoadDepthBuffer(tuv);
	float4 wpos = mul(float4(i.projPos.xy, depth, 1), gViewProjInv);

	float3 normal = LoadNormal(tuv);
	float NoL = max(0, dot(normal, gSunDir));

	wpos.xyz /= wpos.w;
	float3 v = wpos.xyz - gCameraPos;
	float dist = length(v);
	float waterDepth = max(0, dist * (1 + (gCameraPos.y + gOrigin.y - g_Level) / v.y));	// thickness of water

#if  USE_BOTTOM_SHADOW	// project shadow to bottom
	float bottomShadow = SampleShadowCascade(wpos.xyz, depth, gSunDir.xyz*NoL, true, true, false, 1);
	bottomShadow = lerp(1, bottomShadow, calcWaterDeepFactor(waterDepth*0.2, 0));
	NoL = min(NoL, bottomShadow);
#endif

	float isRiver = false;
	if (useMask) {
		//	float waterDeep = waterDeepByMask(i.projPos.xy);
		float4 mask = g_MaskTexture.SampleLevel(SamplerLinearClamp, float2(i.projPos.x, -i.projPos.y) * 0.5 + 0.5, 0);
		float waterDeep = (mask.z - 127.0 / 255) * 20.0;

		uint matID = LoadStencil(tuv);
		isRiver = isSurface(matID) * mask.y;

		waterDepth = lerp(waterDeep, waterDepth, exp(-dist / 2000));	// fix blinking at far, lack of accuracy of waterDepth
	} else {
		waterDepth = lerp(50.0, waterDepth, exp(-dist / 10000));	// fix blinking at far, lack of accuracy of waterDepth
	}

	float deepFactor = calcWaterDeepFactor(waterDepth, 0);
	NoL = lerp(0, NoL, deepFactor);

	float wy = wpos.y + gOrigin.y - g_Level - 1;
	float alpha = max(isRiver, max(exp(-max(wy, 0)), 1 + 1.0 / 255 - exp(-dist / 10000))) * g_UseRefractionFilter;	// prepare for filtering

	PS_OUTPUT o;
	o.sv_target0 = float4(color, alpha);
	o.sv_target1 = float4(NoL,0,0,alpha);
	return o;
}

Texture2D sourceTex;
uint2 dims;

static const float2 filterOffset[] = {
	float2(0, 1),  float2( 1, 0),
	float2(0,-1),  float2(-1, 0)
};

float4 psFilterRefraction(VS_OUTPUT_SS i, uniform uint dist): SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	float4 acc = 0;
	float accNoL = 0;
	[unroll(4)]
	for (uint i = 0; i < 4; ++i) {
		[unroll(dist)]
		for (uint j = 0; j < dist; ++j) {
			float2 offset = filterOffset[i] * (dist - j) / dims;
			float4 col = sourceTex.SampleLevel(gPointClampSampler, uv + offset, 0);
			col.a /= (j + 1);
			acc += float4(col.rgb*col.a, col.a);
			accNoL += g_RefractionNoLTexture.SampleLevel(gPointClampSampler, uv + offset, 0).x*col.a;
		}
	}
	float mul = 1.0 / max(acc.a, 0.0001);
	return float4(acc.rgb * mul, accNoL * mul);
}

PS_OUTPUT psFilterRefractionBack(VS_OUTPUT_SS i) {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	PS_OUTPUT o;
	float4 t = sourceTex.SampleLevel(ClampLinearSampler, uv, 0);
	o.sv_target0 = float4(t.xyz, 1);
	o.sv_target1 = float4(t.w,0,0,1);
	return o;
}

///////////////////////////////////////////////////// Techniques

RasterizerState WireframeMS
{
    CullMode = NONE;
    FillMode = WIREFRAME;
    MultisampleEnable = TRUE;
};

RasterizerState rsBiasWater {
	CullMode = Back;
	FillMode = Solid;
	MultisampleEnable = FALSE;
	DepthBias = -250;			// fix z-fighting with far terrain LOD
};

BlendState waterAlphaBlend {

	BlendEnable[0] = TRUE; // normal
	SrcBlend[0] = SRC_ALPHA;
	DestBlend[0] = INV_SRC_ALPHA;
	BlendOp[0] = ADD;

	BlendEnable[1] = TRUE;	
	SrcBlend[1] = SRC_ALPHA;
	DestBlend[1] = INV_SRC_ALPHA;
	BlendOp[1] = ADD;

	BlendEnable[2] = TRUE;	
	SrcBlend[2] = SRC_ALPHA;
	DestBlend[2] = INV_SRC_ALPHA;
	BlendOp[2] = ADD;

	BlendEnable[3] = TRUE;
	SrcBlend[3] = SRC_ALPHA;
	DestBlend[3] = INV_SRC_ALPHA;
	BlendOp[3] = ADD;
 
	BlendEnable[4] = TRUE;
	SrcBlend[4] = SRC_ALPHA;
	DestBlend[4] = INV_SRC_ALPHA;
	BlendOp[4] = ADD;

	RenderTargetWriteMask[0] = 0x07;
	RenderTargetWriteMask[1] = 0x07; 
	RenderTargetWriteMask[2] = 0x07; 
	RenderTargetWriteMask[3] = 0x07;
	RenderTargetWriteMask[4] = 0x07;
};


technique10 High
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS(true)));
		SetPixelShader(CompileShader(ps_5_0, PS(true, true)));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
#if USE_MASK
		SetBlendState(waterAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#else
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#endif
		SetRasterizerState(rsBiasWater);
	//	SetRasterizerState(WireframeMS);
	}
}

technique10 Medium
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetHullShader(CompileShader(hs_5_0, HS()));
        SetDomainShader(CompileShader(ds_5_0, DS(false)));
		SetPixelShader(CompileShader(ps_5_0, PS(false, false)));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
#if USE_MASK
		SetBlendState(waterAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#else
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#endif
		SetRasterizerState(rsBiasWater);
    }
}

technique10 Low
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetHullShader(CompileShader(hs_5_0, HS_LOW()));
        SetDomainShader(CompileShader(ds_5_0, DS_LOW()));
		SetPixelShader(CompileShader(ps_5_0, PS(false, false)));

		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetRasterizerState(rsBiasWater);
    }
}

technique10 Flat
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS_FLAT()));
		SetPixelShader(CompileShader(ps_5_0, PS(false, false)));

		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetRasterizerState(cullBack);
     }
}

technique10 Draft
{
    pass P0	{          
		SetVertexShader(CompileShader(vs_5_0, VS_FLAT()));
		SetPixelShader(CompileShader(ps_5_0, PS_DRAFT()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetRasterizerState(cullBack);
    }
	pass P1	{
		SetVertexShader(CompileShader(vs_5_0, VS_FLAT()));
		SetPixelShader(CompileShader(ps_5_0, PS_FLIR()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetRasterizerState(cullBack);
	}
	pass P3	{
		SetVertexShader(CompileShader(vs_5_0, VS_FLAT()));
		SetPixelShader(CompileShader(ps_5_0, PS_RADAR()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);

		SetDepthStencilState(Water_DepthStencilState, STENCIL_COMPOSITION_WATER);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetRasterizerState(cullBack);
	}

}

technique10 Wave
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(CompileShader(ps_5_0, PS_WAVE_MASK()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
    }
	pass P1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(CompileShader(ps_5_0, PS_WAVE()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}


BlendState mipAlphaBlend {
	BlendEnable[0] = TRUE;
	SrcBlend[0] = INV_DEST_ALPHA;
	DestBlend[0] = DEST_ALPHA;
	BlendOp[0] = ADD;
	SrcBlendAlpha[0] = ZERO;
	DestBlendAlpha[0] = ZERO;
	BlendOpAlpha[0] = ADD;
	RenderTargetWriteMask[0] = 0x0f;

	BlendEnable[1] = TRUE;
	SrcBlend[1] = INV_DEST_ALPHA;
	DestBlend[1] = DEST_ALPHA;
	BlendOp[1] = ADD;
	RenderTargetWriteMask[1] = 0x01;
};

BlendState refractionAlphaBlend {
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	RenderTargetWriteMask[0] = 0x0f;
	RenderTargetWriteMask[1] = 0x09;
};

technique10 Refraction {
    pass P0	{          
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(refractionAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
	pass P1 {
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(refractionAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass P2 {
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass P3 {
		SetVertexShader(CompileShader(vs_5_0, VS_SS()));
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(mipAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}


}


