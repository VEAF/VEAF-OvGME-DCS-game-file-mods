#ifndef MODEL_DIFFUSE_HLSL
#define MODEL_DIFFUSE_HLSL

#include "functions/alpha_test.hlsl"
#include "functions/decal.hlsl"
#include "functions/damage.hlsl"
#include "deferred/_HMD.hlsl"

float4 calculateDiffuse(const VS_OUTPUT input, inout float3 normal, float dist, inout float sf, inout float sp, inout float reflValue, out float decalMask)
{
#ifdef DIFFUSE_UV

#ifdef NO_DIFFUSE_SS
  float4 diff = Diffuse.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
#else
  // diffuse (albedo) supersampling
  float4 diff = 0;
  const float2 uv = input.DIFFUSE_UV.xy + diffuseShift;
  const float2 sx = ddx(input.DIFFUSE_UV.xy);
  const float2 sy = ddy(input.DIFFUSE_UV.xy);  
#if ENABLE_DIFFUSE_SS == 1
  // 2 sample pattern, D3D11 standard 2xMSAA pattern
  const float bias = -0.425f;
  const int numSamples = 2;
  const float2 pattern[numSamples] = {  
    float2(4 / 16.0, 4 / 16.0),
    float2(-4 / 16.0, -4.0 / 16.0),
  };  
#elif ENABLE_DIFFUSE_SS == 2
  // 4 sample rotated grid, D3D11 standard 4xMSAA pattern
  const float bias = -0.925f;
  const int numSamples = 4;
  const float2 pattern[numSamples] = {  
    float2(-2.0 / 16.0, -6.0 / 16.0),
    float2(6.0 / 16.0, -2.0 / 16.0),
    float2(-6.0 / 16.0, 2.0 / 16.0),
    float2(2.0 / 16.0, 6.0 / 16.0)
  };
#elif ENABLE_DIFFUSE_SS == 3
  // 6 samples, like above, but additional sample points in the middle and at corner. likely not optimal
  const float bias = -1.475f;
  const int numSamples = 6;
  const float2 pattern[numSamples] = {  
    float2(-2.0 / 16.0, -6.0 / 16.0),
    float2(6.0 / 16.0, -2.0 / 16.0),
    float2(-6.0 / 16.0, 2.0 / 16.0),
    float2(2.0 / 16.0, 6.0 / 16.0),
    float2(0, 0),
    float2(0.5, 0.5)
  };
#elif ENABLE_DIFFUSE_SS == 4
  // 8 sample rotated grid, D3D11 standard 8xMSAA pattern
  const float bias = -1.925f;
  const int numSamples = 8;
  const float2 pattern[numSamples] = {
    float2(1.0 / 16.0, -3.0 / 16.0),
    float2(-1.0 / 16.0, 3.0 / 16.0),
    float2(5.0 / 16.0, 1.0 / 16.0),
    float2(-3.0 / 16.0, -5 / 16.0),
    float2(-5.0 / 16.0, 5.0 / 16.0),
    float2(-7.0 / 16.0, -1.0 / 16.0),
    float2(3.0 / 16.0, 7.0 / 16.0),
    float2(7.0 / 16.0, -7.0 / 16.0)
  };
#endif
#if ENABLE_DIFFUSE_SS > 0
  [unroll]
  for (int i = 0; i < numSamples; i++)
    diff += Diffuse.SampleBias(gAnisotropicWrapSampler, uv + (sx * pattern[i].x) + (sy * pattern[i].y), bias);
  diff /= (float) numSamples;
#else
  diff = Diffuse.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
#endif
#endif

	alphaTest(diff.a);

#ifndef SELF_ILLUMINATION_COLOR_MATERIAL
	diff.rgb *= diffuseValue;
#endif
#else
#ifndef COLOR_ONLY
	float4 diff = float4(0.75, 0.75, 0.75, 1.0);
#else
	reflValue = 0.0;
	decalMask = 1.0;
	return float4(color,1.0);
	float4 diff; // to fix compilation
#endif
#endif

	decalMask = addDecal(diff, input, reflValue);
	addDamage(input, dist, diff, normal, sf, sp, reflValue);

	return diff;
}

#endif