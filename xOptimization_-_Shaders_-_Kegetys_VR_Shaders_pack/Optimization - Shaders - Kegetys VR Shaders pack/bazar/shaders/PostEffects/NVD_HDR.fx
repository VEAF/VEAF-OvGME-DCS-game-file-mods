#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/blur.hlsl"
#include "noise/noise3D.hlsl"

Texture2D DiffuseMap;
Texture2D NVDMap;
Texture2D DepthMap;

uint2	dims;
float4	viewport;
float3 color;
float gain;

#include "NVD_common.hlsl"

// Gold Noise ©2015 dcerisano@standard3d.com 
//  - based on the Golden Ratio, PI and Square Root of Two
//  - superior distribution
//  - fastest noise generator function
//  - works with all chipsets (including low precision)

float PHI = 1.61803398874989484820459 * 00000.1; // Golden Ratio   
float PI  = 3.14159265358979323846264 * 00000.1; // PI
float SQ2 = 1.41421356237309504880169 * 10000.0; // Square Root of Two

float gold_noise(in float2 coordinate, in float seed){
    return frac(tan(distance(coordinate*(seed+PHI), float2(PHI, PI)))*SQ2);
}

struct VS_OUTPUT {
	float4 pos:		SV_POSITION;
	float4 projPos:	TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 PS(const VS_OUTPUT i, uniform bool useMask): SV_TARGET0 {

	uint2 idx = i.pos.xy;
	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5)*viewport.zw + viewport.xy;
	
	float3 c1 = NVDMap.SampleLevel(ClampPointSampler, uv, 0).rgb;
	if (useMask) {
		float3 c0 = DiffuseMap.SampleLevel(ClampPointSampler, uv, 0).rgb;

		float2 uvm = calcMaskCoord(i.projPos);

		float m1 = getMask(uvm, 10);
    if (inVR())
    {
      // stretch the black part around the nvg scope
      if (uvm.y > 0)
        uvm.y *= 0.4;    
      if (gProj[2][0] > 0)
      {
        if (uvm.x > 0)
          uvm.x *= 0.3;
      }
      else
      {
        if (uvm.x < 0)
          uvm.x *= 0.3;        
      }
    }
		float m0 = 1 - getMask(uvm*0.725, 3);

		return float4(m0*c0 + m1*c1, 1);
	} else {
		return float4(c1, 1);
	}
}

#define FOCUS_DISTANCE 10.0

float3 BlurOffs(const VS_OUTPUT i, float2 offs, out float depth) {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5);
	depth = DepthMap.SampleLevel(gBilinearClampSampler, uv, 0).r;
	float4 pos = mul(float4(i.projPos.xy, depth, 1), gProjInv);
	float sigma = 0.8 + 2 * saturate((FOCUS_DISTANCE - (pos.z / pos.w)) / FOCUS_DISTANCE);
	return Blur(uv, offs*(0.5 / dims), sigma, NVDMap);
}

float4 PS_BlurX(const VS_OUTPUT i): SV_TARGET0 {
	float depth;
	return float4(BlurOffs(i, float2(1, 0), depth), 1);
}


#define MOD3 float3(.1031,.11369,.13787)
float hash31(float3 p3) {
	p3 = frac(p3 * MOD3);
	p3 += dot(p3, p3.yzx + 19.19);
	return frac((p3.x + p3.y) * p3.z);
}

float noise1(float2 p, float seed) {
	float2 i = floor(p);
	float2 f = frac(p);

	float2 u = f*f*(3.0 - 2.0*f);

	return lerp(
			lerp(hash31(float3(i + float2(0.0, 0.0), seed)),
				hash31(float3(i + float2(1.0, 0.0), seed)), u.x),
			lerp(hash31(float3(i + float2(0.0, 1.0), seed)),
				hash31(float3(i + float2(1.0, 1.0), seed)), u.x),
			u.y);
}

float noise2(float2 p, float seed) {
	float n = noise1(p, seed);
	return (n*0.1 + pow(n, 50)*0.4);
}

float noise3(float2 p, float time) {
  // simple noise + "hot pixels"
  return -(gold_noise(p, time) * NVG_NOISE_STR) + (gold_noise(-p, time*0.23) > NVG_HOTPIXEL_THRESHOLD ? 0.6 : 0);
}


float4 PS_BlurY(const VS_OUTPUT i) : SV_TARGET0 {
	float depth;
	float3 result = BlurOffs(i, float2(0, 1), depth);
#if NVG_GAIN_ADJUSTS_POSITION
  float gain = 0.9;
#endif  
	result *= gain + 0.6;
	result += (max(gain * 0.5, 0.2) - 0.2) * color;

	result += color * noise3((i.projPos.xy*0.5+0.5) * 400, gModelTime * 10);

	return float4(result, 1);
}

technique10 Compose {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(false)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
	pass P1 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}


technique10 BlurX {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_BlurX()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 BlurY {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_BlurY()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

