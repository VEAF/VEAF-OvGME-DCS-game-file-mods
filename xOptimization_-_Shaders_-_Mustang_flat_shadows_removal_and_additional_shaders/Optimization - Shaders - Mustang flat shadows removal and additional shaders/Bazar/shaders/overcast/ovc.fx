#include "common/ambientCube.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "enlight/materialParams.hlsl"
#define FOG_ENABLE
#include "common/fog.hlsl"
#include "common/stencil.hlsl"

Texture2D tracedTex;
Texture2D tracedTexA;
Texture2D tracedTexB;
Texture2D hfTex;
// Texture2D skyTex;
Texture2D expoTex;

float4x4 viewproj;
float4x4 facecam;
float4 cv4;
float4 cam;
float4 cldclr;

float4 cv11;
float4 cv13;
float4 cv20;
float4 cv21;

float4 cv5;
float4 cv6;
float4 cv7;
float4 cv8;
float4 cv40;
float4 cv41;
float4 cv50;
float4 cv51;
float4 cv52;
float4 cv53;
float4 cv54;

float4 cp1;
float4 cp2;

struct VS_OUTPUT_lo
{
    float4 oPos : SV_POSITION;
    float4 oD0 : COLOR0;
    float2 oT0 : TEXCOORD0;
    float3 oT1 : TEXCOORD1;
    float4 oT2 : TEXCOORD2;
    float2 oT3 : TEXCOORD3;
    float3 worldPos : TEXCOORD4;
    float4 projPos : TEXCOORD5;
    float4 oT6 : TEXCOORD6;

};
VS_OUTPUT_lo VertOutLo(float2 vPos : POSITION) 
{
	VS_OUTPUT_lo OUT;
	float4 tw;
	tw.x=vPos.x;
	tw.z=vPos.y;
	tw.w=2.0;
	float d=tw.x*tw.x+tw.z*tw.z;

	tw.y=1-d*d;

	OUT.oT1.xyz=normalize(tw.xyz);

	tw.xz*=cv4.x;
	tw.y*=cv11.z;
	tw.y-=cv20.y;

//	tw.y=max(tw.y,0);
	float4 pos=mul(tw,viewproj);
	OUT.oT6=tw;
	OUT.oPos=pos;
	OUT.projPos=pos;

	OUT.worldPos = tw.xyz/tw.w + float3(gViewInv._m30, gViewInv._m31, gViewInv._m32);

	OUT.oT2.x= pos.x*0.5+pos.w*0.5;
	OUT.oT2.y=-pos.y*0.5-pos.w*0.5;
	OUT.oT2.zw=pos.zw;

	OUT.oD0.w=1-min(1,max(0,pos.w-cv13.z)*cv13.w);
	OUT.oD0.xyz=cv13.x;

	float2 r0xy=((vPos.xy+cv21.xy)*1.0+1.0)*cv13.y*4;
	OUT.oT0=r0xy;
	OUT.oT3=r0xy;
	return OUT;
}

//я вас таки умоляю, пишите структурами
struct VS_OUTPUT_hi
{
    float4 oPos : SV_POSITION;
    float4 oD0 : COLOR0;
    float2 oT0 : TEXCOORD0;
    float4 oT3 : TEXCOORD3;
#ifndef USE_DCS_DEFERRED
	float3 worldPos : TEXCOORD4;
#endif
};

VS_OUTPUT_hi VertOutHi(float2 vPos : POSITION) 
{
	VS_OUTPUT_hi OUT;
	float4 tw;

	tw.x=vPos.x;
	tw.y=cv11.z; 
	tw.z=vPos.y;
	tw.w=1.0;

	tw.xz*=cv4.x;
	tw.y-=cv20.y;

	float4 pos=mul(tw,viewproj);
	OUT.oPos=pos;
#ifndef USE_DCS_DEFERRED
	OUT.worldPos = tw.xyz / tw.w;
#endif
	OUT.oT3.x= pos.x*0.5+pos.w*0.5;
	OUT.oT3.y=-pos.y*0.5-pos.w*0.5;
	OUT.oT3.zw=pos.zw;

	OUT.oD0.w=1/(pow(2,pos.w*cv13.w));
	OUT.oD0.xyz=cv13.x;

	float2 r0xy=(vPos.xy+cv21.xy)*cv13.y*1.2;
	OUT.oT0=r0xy;
//	oT1=r0xy;
//	oT2=r0xy;

	return OUT;
}
//я вас таки умоляю, пишите структурами
struct VS_OUTPUT_Ptcls
{
    float4 oPos : SV_POSITION;
    float4 oD0 : COLOR0;
    float2 oT0 : TEXCOORD0;
#ifndef USE_DCS_DEFERRED
	float3 worldPos : TEXCOORD4;
#endif
};

VS_OUTPUT_Ptcls VertOutPtcls(float3 vPos : POSITION, float2 vTex : TEXCOORD)
{
	VS_OUTPUT_Ptcls OUT;
	float4 tw;

	tw.xy=vTex.xy*cv4.x;
	tw.z=0;
	tw.w=1.0;

	float4 t=mul(tw,facecam);
	float3 r2=(vPos*cv6.x+cv5.xyz)-cv7.xyz;
	t.xyz+=r2;
	t.w=1;

	float4 pos=mul(t,viewproj);
	OUT.oPos=pos;
	OUT.oT0.xy=vTex.xy*0.5+0.5;
#ifndef USE_DCS_DEFERRED
	OUT.worldPos = t.xyz / t.w;
#endif
	float r3y=1-max(abs(t.y-cv6.y+cv7.y)-cv6.z,1)*cv6.w;
	float r4w=1-min(1,length(r2)*cv8.x);
	float r4y=min(2,max(0,(r2.y-cv8.y+cv7.y)*cv8.z));
	float4 r5=(1-r4y)*cv40;
	float4 r6=r4y*cv41;
	//float r1w=length(t-cv51);
	//r6+=pow(1-min(1,r1w*cv50.x),6)*cv53*cv51.w;
	//r1w=length(t-cv52);
	//r6+=pow(1-min(1,r1w*cv50.y),6)*cv54*cv52.w;
	
	OUT.oD0.xyz=r5+r6;
	OUT.oD0.w = saturate((pos.w+2)*0.6) * r3y * r4w;
	// OUT.oD0.w = r3y * r4w;
	
	// OUT.oD0.w = r3y * r4w;

	return OUT;
}

float4 PixOutLo(VS_OUTPUT_lo input): SV_TARGET0
{
#ifndef USE_DCS_DEFERRED
	clipInCockpit(input.worldPos);
#endif
	float4 t0=tracedTex.Sample(WrapLinearSampler, input.oT0);
	float4 t1=hfTex.Sample(WrapLinearSampler, input.oT0);
	float4 t2=skyTex2.Sample(WrapLinearSampler, input.oT2.xy/input.oT2.w);
	float4 t3=expoTex.Sample(WrapLinearSampler, input.oT3);
	float L=dot(normalize(input.oT1),normalize(cp1.xyz));
	float r1a=2*L*L*(1-t3.z);
	float4 r0;
	r0.xyz = (t0+r1a+t2*t3.a) * cldclr;//*cp2.b);
#ifdef USE_DCS_DEFERRED
	r0.xyz *= (AmbientTop.rgb + AmbientTop.bbb) * 1.0 * cldclr * 1.5;
#endif

	float4 cOut;
	cOut.xyz = lerp(r0.xyz, t2, 1-input.oD0.w);
	cOut.a = saturate(4*(t1.b-input.oD0.b));

	// Alpha test
	clip(cOut.a); // 0 is the same as ALPHAREF = 0

	fogApply(gCameraPos.xyz, input.worldPos, input.projPos, cOut.rgb);
	// float3 pos = input.worldPos.xyz - gCameraPos.xyz;
	// float dist = length(pos);
	// float cosEta = pos.y / dist;
	// float attL = fogCalcAttenuation(FogCoefficients.x, FogCoefficients.y, FogCamHeight, dist*100, cosEta);	
	// Out.cOut.rgb = lerp(FogColor, Out.cOut.rgb, attL);

    return cOut;
}

float4 PixOutHi(VS_OUTPUT_hi input): SV_TARGET0
{ 
#ifndef USE_DCS_DEFERRED
	clipInCockpit(input.worldPos);
#endif

	float4 cOut;
	float4 t0=tracedTexA.Sample(WrapLinearSampler, input.oT0);
	float4 t1=tracedTexB.Sample(WrapLinearSampler, input.oT0);
	float4 t2=hfTex.Sample(WrapLinearSampler, input.oT0);
	float4 t3=skyTex2.Sample(WrapLinearSampler, input.oT3.xy/input.oT3.w);

	float4 r1 = lerp(t0,t1,1-cp2.a);
	r1.rgb *= cp2;
#ifdef USE_DCS_DEFERRED
	r1.rgb *= cp2 * max(gSunIntensity*0.3, AmbientTop.b)-1.0;
#endif

	float r0a = saturate(t2.b-input.oD0.b);

	cOut.rgb = lerp(r1, t3, saturate(1-input.oD0.a));
	cOut.a=saturate(r0a+cp1.a)-0.01;

	if (cOut.a < 0.01) // 0 is the same as ALPHAREF = 0
		discard;

	return cOut;
}

float4 PixOutPtcls(VS_OUTPUT_Ptcls input): SV_TARGET0
{
#ifndef USE_DCS_DEFERRED
	clipInCockpit(input.worldPos);
#endif

	float4 cOut;
	cOut.rgb = input.oD0.rgb;
#ifdef USE_DCS_DEFERRED
	cOut.rgb *= input.oD0.rgb * max(gSunIntensity*0.6, AmbientTop.b)-2;
#endif
	cOut.a = tracedTex.Sample(WrapLinearSampler, input.oT0.xy).r * input.oD0.a;
	if (cOut.a < 0.01)
		discard;

	return cOut;
}

technique10 ovc_low
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutLo()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOutLo()));
#ifdef USE_DCS_DEFERRED
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
#endif
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }

technique10 ovc_hi
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutHi()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOutHi()));
#ifdef USE_DCS_DEFERRED
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
#endif
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }


technique10 ovc_ptcls
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutPtcls()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOutPtcls()));
#ifdef USE_DCS_DEFERRED
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
#endif
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
}
