#ifndef GLASS_HLSL
#define GLASS_HLSL

#define NO_DIFFUSE_SS // no supersampling for glass please

#define INFRARED_SHADERS
#define FOG_ENABLE
#define EXTERN_UNIFORM_LIGHT_COUNT
#define EXTERN_UNIFORM_CLOUDS_COLOR_ID
#ifndef SHADING_MODEL
	#define SHADING_MODEL	SHADING_GLASS
#endif

#include "common/enums.hlsl"
#include "common/context.hlsl"

#include "functions/misc.hlsl"
#include "functions/vertex_shader.hlsl"
#include "functions/vt_utils.hlsl"
#include "functions/scratches.hlsl"
#include "functions/matParams.hlsl"
#include "functions/aorms.hlsl"

#include "functions/satellite.hlsl"
#include "functions/map.hlsl"
#include "functions/infrared.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/color_table.hlsl"
#include "common/debug_uniforms.hlsl"
#endif

Texture2D RainDroplets: register(t104);
Texture2D CockpitRefraction: register(t103);

struct PS_OUTPUT_GLASS {
	float4 colorAdd : SV_TARGET0;
	float4 colorMul : SV_TARGET1;
};

#define CALC_GLASS_FRESHEN			1
#define CALC_GLASS_TRANSMITTANCE	0 //for the future

#include "functions/shading.hlsl"
#include "../deferred/_HMD.hlsl"

float3 getScatteringCoef(float3 T, float dist){
	return log(float3(1.0,1.0,1.0) / T) / dist;
}

float3 getTransmittance(float3 scatteringCoef, float dist){
	return exp(-scatteringCoef*dist);
}

float3 getTransmittance(float3 t0, float D0, float dist){
	return getTransmittance(getScatteringCoef(t0, D0), dist);
}

//reflected energy lobe - modified Shlick's approximation for the critical angle of total internal reflection, cosAlpha = NoV
float getFresnelFactor(float cosAlpha, float cosAlphaCrit){
	return pow(saturate(1.0 - (cosAlpha + (cosAlphaCrit - 1.0)) / cosAlphaCrit), 5.0);
}

//cosine of refraction angle (NoR)
float getCosGamma(float cosAlpha, float N1, float N2){
	return sqrt(1.0 - N1*N1*(1.0-cosAlpha*cosAlpha)/(N2*N2));
}

//refracted ray length relative to incidence angle of 0 degrees and a shell of unit thickness
float getRefractedRayLength(float cosAlpha, float N1, float N2){
	return 1.0 / getCosGamma(cosAlpha, N1, N2);
}

#if ENABLE_SIMPLE_CANOPY
float4 forwardGlassPSPass2(VS_OUTPUT input, MaterialParams mp, uniform int Flags, out float3 transmittance)
{
	float shadow = 1.0;
	float3 aorm = getAORMS(input, mp.specular, mp.decalMask);
	
	if(!(Flags & F_DISABLE_ATMOSPHERE))
	{
		mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, aorm.x);
		float3 sunColor = analyticSunColor((mp.pos.y + gOrigin.y) * 0.001, gSunDir) * gOvercastFactor;
		float3 emissive = mp.illumination.rgb * mp.illumination.a;
		float4 finalColor = float4(ShadeTransparent(input.Position.xy, sunColor, mp.diffuse.rgb, mp.diffuse.a, mp.normal, aorm.y, aorm.z, emissive, shadow, mp.toCamera, mp.pos, true), mp.diffuse.a);
		float3 inscatter;
		MaterialParams mp = calcMaterialParams(input);
		ComputeFogAndAtmosphereCombinedFactors(mp.pos, gCameraPos, gCameraHeightAbs, gFogCameraHeightNorm, transmittance, inscatter, sunColor);

		finalColor.rgb = finalColor.rgb*transmittance + inscatter;
		return finalColor;		
	}
	else
	{
		// inside, very simple
		transmittance = 1;
	
		mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, 1);

		// super simple shading
		float NoL = min(0.9, max(0, dot(mp.normal, gSunDir) + 0.5));
		float up = 1 - gSunAttenuation;    
		return float4((mp.diffuse.rgb * saturate(pow(NoL, 2)) * up * 0.21 * saturate(pow(mp.camDistance, 2))), 0);
	}
}
#else
float4 forwardGlassPSPass2(VS_OUTPUT input, MaterialParams mp, uniform int Flags, out float3 transmittance)
{
	float shadow = 1.0;
	if(!(Flags & F_ABOVE_CLOUDS))
		shadow = min(shadow, applyCloudShadow(mp.pos));
	if(!(Flags & F_DISABLE_SHADOWMAP))
		shadow = min(shadow, applyShadow(float4(mp.pos, input.projPos.z/input.projPos.w), mp.normal));

	float4 aorm = getAORMS(input, mp.specular, mp.decalMask);
	mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, aorm.x);

	//todo: ???????? ??????????????? ?????? ??? ????? ???????
	float3 sunColor = analyticSunColor((mp.pos.y + gOrigin.y) * 0.001, gSunDir) * gOvercastFactor;

	float4 finalColor;

	float3 emissive = mp.illumination.rgb * mp.illumination.a;

	finalColor = float4(ShadeTransparent(input.Position.xy, sunColor, mp.diffuse.rgb, mp.diffuse.a, mp.normal, aorm.y, aorm.z, emissive, shadow, mp.toCamera, mp.pos, true, gInsideCockpit), mp.diffuse.a);
	finalColor.rgb += calcScratches(input, shadow);

	if(!(Flags & F_DISABLE_ATMOSPHERE))
	{
		float3 inscatter, sunColor;
		MaterialParams mp = calcMaterialParams(input);
		ComputeFogAndAtmosphereCombinedFactors(mp.pos, gCameraPos, gCameraHeightAbs, gFogCameraHeightNorm, transmittance, inscatter, sunColor);

		finalColor.rgb = finalColor.rgb*transmittance + inscatter;
	}
	else transmittance = 1.0;

	return finalColor;
} 
#endif

void calcGlassColors(VS_OUTPUT input, uniform int Flags, out float4 colorMul, out float4 colorAdd)
{
	float3 transmittance;
	MaterialParams mp = calcMaterialParams(input);
	colorAdd = forwardGlassPSPass2(input, mp, Flags, transmittance);

#ifdef DIFFUSE_UV
	colorMul = GlassColorMap.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
#else
	colorMul = float4(1, 0, 0, 1);
#endif

#if !ENABLE_SIMPLE_CANOPY //CALC_GLASS_FRESHEN
	static const float d0 = 1.0;//medium thickness for incidence angle of 0 degrees
	static const float n1 = 1.000292; //air
	static const float n2 = 1.49; //plexiglass
	// static const float n2 = 1.334; //water

	//RoVcrit - critical cosine of the total internal reflection while transmitting light from n2 to n1.
	//Should be determined over the surface curvature and the medium thickness, or adjusted visually for a suitable result
	static const float RoVcrit = 0.98;
	static const float inscatterFactor = 0.5;//artistic choice

	float3 T0 = GammaToLinearSpace(colorMul.rgb);
	colorMul.rgb = transmittance - transmittance*colorAdd.aaa;

	//transmitted light
	float NoV = dot(mp.normal, mp.toCamera);
	float Ft = 1.0 - getFresnelFactor(NoV, RoVcrit);//energy lobe

	#if CALC_GLASS_TRANSMITTANCE
		float d = d0 * getRefractedRayLength(NoV, n1, n2);
		float3 scatteringCoef = getScatteringCoef(t0, d0);
		colorMul.rgb *= getTransmittance(scatteringCoef, d) * (Ft * (1.0-getFresnelFactor(NoV, 1.0)));
		//magic approximation: inscattered light within shell thickness
		colorAdd.rgb += getTransmittance(scatteringCoef, d*4.0) * AmbientAverage * ((1.0 - Ft) * inscatterFactor);
	#else
		colorMul.rgb *= T0 * (Ft * (1.0-getFresnelFactor(NoV, 1.0)));
		//magic approximation: inscattered light within shell thickness
		colorAdd.rgb += T0 * AmbientAverage * ((1.0 - Ft) * inscatterFactor);
	#endif

#else
	colorMul.rgb = GammaToLinearSpace(colorMul.rgb);
	colorMul.rgb *= transmittance - transmittance*colorAdd.aaa;
#endif
}

PS_OUTPUT_GLASS forward_ps_pass1(VS_OUTPUT input, uniform int Flags) {
	PS_OUTPUT_GLASS o;

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	o.colorMul = colorMul;
	o.colorAdd = colorAdd;

#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		o.colorAdd.rgb = color_table[NodeId % N_COLORS];
	}
#endif

	return o;
}

// TODO refactoring, MeltFactor is deprecated
#define viewportSize float2(MeltFactor.yz)

float4 forward_ps_pass_droplets(VS_OUTPUT input, uniform int Flags): SV_TARGET0 {

#ifdef DIFFUSE_UV

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	float2 uv = input.DIFFUSE_UV.xy + diffuseShift;

	float3 normal = normalize(input.Normal);
#ifdef NORMAL_MAP_UV
	float3 tangent = normalize(input.Tangent.xyz);
#else
	float3 tangent = normal;
#endif
	float3x3 tangentSpace = { tangent, cross(normal, tangent), normal };

	float3 n = normalize((RainDroplets.Sample(gTrilinearWrapSampler, uv).xyz - 127.0 / 255) * 2);
	n.z = sqrt(1 - dot(n.xy, n.xy));
	n = mul(n, tangentSpace);

	float2 ruv = float2(input.projPos.x, -input.projPos.y) / input.projPos.w;
	float3 duv = mul(normal - n, (float3x3)gView);

	float4 colorDst;
	[unroll]
	for (int i = 2; i >= 0; --i) {
		duv *= 0.5 * sign(i);
		colorDst = CockpitRefraction.SampleLevel(gBilinearClampSampler, viewportSize * saturate((ruv + duv.xy) * 0.5 + 0.5), 0);
		[branch]
		if (colorDst.a == 0)
			break;
	}

	colorDst.xyz = lerp(colorDst.xyz, SampleEnvironmentMapLevel(ClampLinearSampler, -n, 4).xyz, saturate(dot(duv.xy, duv.xy) * 5));

	return colorDst * colorMul + colorAdd;

#else
	return float4(1, 0, 0, 1);
#endif
}

float4 glassFLIR_ps(VS_OUTPUT input): SV_TARGET0 {
	return float4(1,1,0,1);
}

#endif
