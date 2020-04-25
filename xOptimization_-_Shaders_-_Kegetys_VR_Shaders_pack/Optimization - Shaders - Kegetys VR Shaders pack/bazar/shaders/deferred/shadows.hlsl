#ifndef DEFERRED_SHADOWS_HLSL
#define DEFERRED_SHADOWS_HLSL

#include "common/samplers11.hlsl"
#include "enlight/materialParams.hlsl"
#include "_HMD.hlsl"

#define USE_ROTATE_PCF 1

#if USE_ROTATE_PCF
float rnd(float2 xy) {
	return frac(sin(dot(xy, float2(12.9898, 78.233))) * 43758.5453);
}
#endif

float SampleShadowMap(float3 wPos, float depth, float3 normal, uniform uint idx, uniform bool usePCF, uniform bool useNormalBias, uniform uint samplesMax, uniform bool useTreeShadow)
{
	float NoL = 1;
	float bias = 0.00025;

	if (useNormalBias) {
		NoL = dot(normal, gSunDir.xyz);
		bias = clamp(bias * 5.0 * sqrt(1.0 - NoL * NoL) / NoL, bias * 0.33, bias);
	}

	float4 shadowPos = mul(float4(wPos, 1.0), ShadowMatrix[idx]);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	float acc = cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) - bias);

#if ENABLE_SIMPLE_SHADOWS
	// reduced sample count
  samplesMax = min(samplesMax, 10);
#endif
	if (useTreeShadow) {
		float4 projPos = mul(float4(wPos, 1.0), gViewProj);
		float dp = cascadeShadowMap.SampleLevel(gPointClampSampler, float3(shadowCoord.xy, 3 - idx), 0).x;
		float4 p = mul(float4(shadowPos.xy, dp, 1.0), ShadowMatrixInv[idx]);
		float d = dot(p.xyz / p.w - wPos, gSunDir);
		return max(exp(-d * 0.5), acc);
	}

	if (usePCF) {
		static const float incr = 3.1415926535897932384626433832795 *(3.0 - sqrt(5.0));
		const uint count = min(16, samplesMax);

		const float radius = 3.0 / ShadowMapSize;

		float offs = 1.0 / count; 
		float angle = 0, offset = 0;;
#if USE_ROTATE_PCF
		float4 projPos = mul(float4(wPos, 1.0), gViewProj);
		angle += rnd(projPos.xy/ projPos.w);
#endif
		[unroll(count)]
		for (uint i = 0; i < count-1; ++i) {
			offset += offs;
			angle += incr;
			float s, c;
			sincos(angle, s, c);
			float2 delta = float2(c, s) * (offset * radius);
			acc += cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy+delta, 3 - idx), saturate(shadowCoord.z) - bias * (1.0 + offset * 7.0) );
		}
		acc /= count;
	} 

	if(useNormalBias) {
		float mn = min(NoL*10, 1);
		return min(mn, acc);
	} 

	return acc;
}

float CloudsShadow(float3 pos) {
	float4 cldShadowPos = mul(float4(pos + gOrigin.xyz, 1.0), gCloudShadowsProj);
	return cloudsShadowTex.SampleLevel(gCloudsShadowSampler, cldShadowPos.xy / cldShadowPos.w, 0).r;
}

float SampleShadowCascade(float3 wPos, float depth, float3 normal, uniform bool usePCF, uniform bool useNormalBias, uniform bool useTreeShadow=false, uniform uint samplesMax=32) {	// normal in world space

	if (useNormalBias) {
		float NdotL = dot(normal, gSunDir.xyz);

		if (NdotL < 0)
			return 0;
	}
#if 0	// try to optimize branches, don't improve performance on NVIDIA, TODO: check on ADM
	uint idx = 3 - max(max(uint(depth > ShadowDistance[0]) * 3, uint(depth > ShadowDistance[1]) * 2), uint(depth > ShadowDistance[2]));
	if (idx < 3)
		return SampleShadowMap(wPos, depth, normal, idx, usePCF, useNormalBias, samplesMax, useTreeShadow);
#else
	if (depth > ShadowDistance[0])
		return SampleShadowMap(wPos, depth, normal, 0, usePCF, useNormalBias, samplesMax, useTreeShadow);

	if (depth > ShadowDistance[1])
		return SampleShadowMap(wPos, depth, normal, 1, usePCF, useNormalBias, samplesMax, useTreeShadow);

	if (depth > ShadowDistance[2])
		return SampleShadowMap(wPos, depth, normal, 2, usePCF, useNormalBias, samplesMax, useTreeShadow);
#endif
	if (depth > ShadowDistance[3]) {
		if (useTreeShadow)
			return max(SampleShadowMap(wPos, depth, normal, 3, usePCF, useNormalBias, samplesMax, true), smoothstep(ShadowDistance[2], ShadowDistance[3], depth));
		else
			return max(SampleShadowMap(wPos, depth, normal, 3, usePCF, useNormalBias, samplesMax, false), smoothstep(ShadowCascadeFadeDepth, ShadowDistance[3], depth));
	}
	return 1;
}	

float SampleShadowMapVertex(float3 wPos, uniform uint idx) {

	float bias = 0.0025;

	float4 shadowPos = mul(float4(wPos, 1.0), ShadowMatrix[idx]);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	return cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) - bias);
}

float SampleShadowCascadeVertex(float3 wPos, float depth) {

	[unroll]
	for (uint i = 0; i < 4; ++i) 
		if (depth > ShadowDistance[i])
			return SampleShadowMapVertex(wPos, i);

	return 1;
}



#endif
