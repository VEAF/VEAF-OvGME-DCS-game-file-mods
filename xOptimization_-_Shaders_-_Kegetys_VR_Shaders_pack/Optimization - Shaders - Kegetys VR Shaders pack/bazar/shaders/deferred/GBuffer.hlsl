#ifndef GBUFFER_HLSL
#define GBUFFER_HLSL

#include "common/context.hlsl"
#include "deferred/packNormal.hlsl"
#include "deferred/packColor.hlsl"
#include "deferred/packFloat.hlsl"
#include "deferred/deferredCommon.hlsl"

//enum
#define COVERAGE_WITHIN_METALLIC	1
#define COVERAGE_WITHIN_AO			2

#define USE_SV_SAMPLEINDEX	0
#define USE_MASK_IC			1
#define USE_SEPARATE_AO		1

#define USE_COVERAGE		0
// #if USE_SEPARATE_AO == 1
	// #define USE_COVERAGE	COVERAGE_WITHIN_AO
// #else
	// #define USE_COVERAGE	COVERAGE_WITHIN_METALLIC
// #endif

#ifndef DISABLE_MOTION_BLUR
	#define USE_VELOCITY_MAP 1
#endif

#define VELOCITY_MAP_SCALE 0.1


#if defined(MSAA) && USE_SV_SAMPLEINDEX
	#undef USE_MASK_IC
	#define USE_MASK_IC 0
#endif

struct GBuffer {
	float4 target0 : SV_TARGET0;
	float4 target1 : SV_TARGET1;
	float4 target2 : SV_TARGET2;
	float4 target3 : SV_TARGET3;
#if USE_SEPARATE_AO
	// target4 removed to save bandwidth
	//float4 target4 : SV_TARGET4;
#endif
#if USE_VELOCITY_MAP
	float4 target5 : SV_TARGET5;
#endif
};

static const float4 MAX_SPECULAR = float4(100.0, 3.0, 1, 1);
static const float emissiveLumMin = 0.1 / 255.0;

float2 speculamapToRoughnessMetallic(float4 specularMap) {
	specularMap /= MAX_SPECULAR;//нормализуем обратно к 1 
	// float roughness = clamp(1-specularMap.x, 0.01, 0.99); // factor
	// float roughness = clamp(1-specularMap.y, 0.01, 0.99)*0.85; // power
//	float roughness = clamp((1-specularMap.y*2.3)*0.4, 0.02, 0.99); // power
	float roughness = clamp((1-specularMap.y*2.3), 0.02, 0.99); // power
	float metallic = specularMap.z; // reflection power
//	float metallic = specularMap.w; // reflection blur
//	float metallic = min(1, (0.5*specularMap.z + 0.5*specularMap.w) * 1.4);
	// return roughness;
	// return metallic;
	return float2(roughness, metallic);
}

float2 packInterlaced(uint2 pidx, float2 v1, float2 v2) {
	uint idx = (pidx.x ^ pidx.y) & 1;
	return idx ? v2 : v1;
}

float2 calcVelocityMap(float4 projPos, float4 prevProjPos) {
	return (projPos.xy / projPos.w - prevProjPos.xy / prevProjPos.w)*(VELOCITY_MAP_SCALE / gPrevFrameTimeDelta)*0.5 + 127.0 / 255.0;
}

float2 calcVelocityMapStatic(float4 projPos) {
	return calcVelocityMap(projPos, mul(projPos, gPrevFrameTransform));
}

GBuffer BuildGBuffer(float2 sv_pos_xy, 
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex, 
#endif
	float4 color, float3 normal, float4 aorms, float3 emissive, float2 velocityMap, bool coverage, float normalBlendTreshold = 0.5) {
	GBuffer o;

	const float emissiveMaxValueInv = 1.0 / 1.5;

#if USE_SV_SAMPLEINDEX
	uint2 idx = uint2(uint(sv_pos_xy.x)*GetRenderTargetSampleCount()+sv_sampleIndex, sv_pos_xy.y);
#else
	uint2 idx = uint2(uint(sv_pos_xy.x), sv_pos_xy.y);
#endif
	float3 ec = encodeColorYCC(color.xyz);
	float3 ic = encodeColorYCC(emissive * emissiveMaxValueInv);

	bool bValidEmissive = ic.x >= emissiveLumMin;

	float normalAlpha = step(normalBlendTreshold, color.a);

	o.target0 = float4(packNormal(float3(normal.xz, -abs(normal.y)))*0.5+0.5, 0, normalAlpha);
	
	// If no emissivity then pack AO in place of emissivity
	o.target1 = float4(ec.x, packFloat1Bit(bValidEmissive ? ic.x : aorms.x, bValidEmissive), 0, color.a);
	float2 c = packInterlaced(idx, ec.yz, ic.yz);
#if USE_MASK_IC
	o.target2 = float4(bValidEmissive ? c : ec.yz, 0, color.a);
#else
	o.target2 = float4(c, 0, color.a);
#endif

	aorms.y = packFloat1Bit(aorms.y, normal.y>0);
#if USE_COVERAGE == COVERAGE_WITHIN_METALLIC
	aorms.z = packFloat1Bit(aorms.z, coverage);
#elif USE_COVERAGE == COVERAGE_WITHIN_AO
	aorms.x = packFloat1Bit(aorms.x, coverage);
#endif
	o.target3 = float4(aorms.yz, 0, color.a);
//	o.target3 = float4(aorms.yz, 0, normalAlpha);
#if USE_SEPARATE_AO
	// target4 removed to save bandwidth
	//o.target4 = float4(aorms.xw, 0, color.a);
#endif
#if USE_VELOCITY_MAP
	o.target5 = float4(velocityMap, 0, color.a);
#endif
	return o;
}
 
GBuffer BuildGBufferStatic(float2 sv_pos_xy, 
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex, 
#endif
	float4 color, float3 normal, float4 aorms, float3 emissive, float4 projPos, bool coverage, float normalBlendTreshold = 0.5) {
	return  BuildGBuffer(sv_pos_xy, 
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		color, normal, aorms, emissive, calcVelocityMapStatic(projPos), coverage, normalBlendTreshold);
}

GBuffer BuildGBufferWater(float4 color, float3 normal, float wLevel, float foam, float deepFactor, float bottomNoL, float4 projPos, float riverLerp) {
	GBuffer o;

	float3 ec = encodeColorYCC(color.xyz);
	o.target0 = float4(packNormal(float3(normal.xz, -abs(normal.y)))*0.5+0.5, 0, color.a);
	o.target1 = float4(ec.x, foam, 0, color.a);
	o.target2 = float4(ec.yz, 0, color.a);
	float2 t3 = float2(wLevel, bottomNoL);
	t3.x = packFloat1Bit(t3.x, normal.y>0);
	o.target3 = float4(t3, 0, color.a);
#if USE_SEPARATE_AO
	// target4 removed to save bandwidth
	//o.target4 = float4(deepFactor, riverLerp, 0, color.a);
#endif
#if USE_VELOCITY_MAP
	o.target5 = float4(calcVelocityMapStatic(projPos), 0, color.a);
#endif
	return o;
}

#endif
