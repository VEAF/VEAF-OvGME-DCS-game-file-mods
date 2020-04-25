#include "common/states11.hlsl"
#include "common/samplers11.hlsl"

#include "common/context.hlsl"

Texture2D tex;

#ifdef MSAA
	Texture2DMS<float, MSAA> texDepth;
	float loadDepth(uint2 uv, uint idx)	{	return texDepth.Load(uint2(uv), idx).x;	}
#else
	Texture2D<float> texDepth;
	float loadDepth(uint2 uv, uint idx) {	return texDepth.Load(uint3(uv, 0)).x;	}
#endif

float3 source, direction;
float4 color;	
float2 size;

static const float rayLength = 10.0;

static const float2 offs[4] = {
    float2(-1, -1),  float2(1, -1),
    float2(-1, 1),  float2(1, 1)
};

#define MapSampler gBilinearClampSampler

struct psInput
{
	float4 sv_pos:		SV_POSITION0;
	float4 projPos:		TEXCOORD0;
};

float4 VS(uint vid: SV_VertexID): POSITION0 {
	return float4(source + direction*rayLength, 1);
}

[maxvertexcount(4)]
void GS(point float4 input[1]: POSITION0, inout TriangleStream<psInput> outputStream) {
	psInput o;

	float4 position = mul(input[0], gView);

	[unroll]
	for(int i=0; i<4; ++i) {

		float3 p = position.xyz / position.w;
	
		p.xy += offs[i].xy*size.y*rayLength*10.0;

		o.sv_pos = o.projPos = mul(float4(p, 1), gProj); 
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 PS(const psInput i, uint sidx: SV_SampleIndex): SV_TARGET0 {

	uint2 uv = i.sv_pos.xy;
	float depth = loadDepth(uv, sidx);
	float4 wPos = mul(float4(i.projPos.xy/i.projPos.w, depth, 1), gViewProjInv);
	float3 dir = normalize(wPos.xyz/wPos.w - source);

	float d = dot(dir, direction);

	float sp=smoothstep(size.x, 1, d);	// spot 

	clip(d-size.x);
	
	float3 vU = normalize(cross(float3(0,1,0),direction));
	float3 vV = normalize(cross(direction, vU));
	float2 tuv = float2(dot(vU, dir), dot(vV, dir))/size.y*0.5+0.5;
	float4 clr = tex.Sample(ClampLinearSampler, tuv);
	return clr *(sp+0.5) * saturate(0.275 + dot(gSunDiffuse, 0.33));
}


BlendState xorAlphaBlend {
	BlendEnable[0] = TRUE;
	SrcBlend = INV_DEST_COLOR;
	DestBlend = INV_SRC_COLOR;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 normal {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
//		SetBlendState(xorAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

