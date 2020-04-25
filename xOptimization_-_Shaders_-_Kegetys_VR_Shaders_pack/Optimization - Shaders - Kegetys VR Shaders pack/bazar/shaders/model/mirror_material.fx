#include "common/uniforms.hlsl"
#include "common/textures.hlsl"
#include "functions/vertex_shader.hlsl"
#include "functions/matParams.hlsl"
#include "functions/impostor.hlsl"

#include "functions/lk_shadow.hlsl"
#include "common/ShadowStates.hlsl"

#include "common/shader_macroses.hlsl"
#include "common/states.hlsl"
#include "common/states11.hlsl"

#include "deferred/GBuffer.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/debug_uniforms.hlsl"
#endif

GBuffer mirrorPS_Zpass(VS_OUTPUT input, uint sv_coverage: SV_Coverage) {

	float4 aorms = float4(0,0,0,0);
	bool coverage = 1;

#if USE_COVERAGE
	coverage = sv_coverage != COVERAGE_MASK;
#endif

	GBuffer o;
#if USE_COVERAGE == COVERAGE_WITHIN_METALLIC
	aorms.z = packFloat1Bit(aorms.z, coverage);
	o.target3 = float4(aorms.yz, 0, 1);
#elif USE_COVERAGE == COVERAGE_WITHIN_AO
	aorms.x = packFloat1Bit(aorms.x, coverage);
	//o.target4 = float2(aorms.xw);
#endif
	return o;
}

float4 mirrorPS(VS_OUTPUT input): SV_TARGET0
{
	const float mirrorAlbedo = 0.8 * 0.85;//mirror albedo through glass transparency

	MaterialParams mp = calcMaterialParams(input);
	return mp.diffuse * mirrorAlbedo;
}

VertexShader_t model_vs_c = COMPILE_VERTEX_SHADER(model_vs());
PixelShader_t mirrorPS_c = COMPILE_PIXEL_SHADER(mirrorPS());

TECH_NAME_GEN(normal_cockpit, _cf)
{
	pass P0
	{
		SetVertexShader(model_vs_c);
		SetPixelShader(COMPILE_PIXEL_SHADER(mirrorPS_Zpass()));
		SetGeometryShader(NULL);
		SetRasterizerState(cullFront);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferCP, STENCIL_COMPOSITION_EMPTY);
	}
	pass P1
	{
		SetVertexShader(model_vs_c);
		SetPixelShader(mirrorPS_c);
		SetGeometryShader(NULL);
		SetRasterizerState(cullFront);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
	}
}

TECH_NAME_GEN(normal, _cf) {
	pass P0  {
		SetVertexShader(model_vs_c);
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
	}
}

TECHNIQUE impostor {
	pass P0  {
		SetVertexShader(NULL);
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
	}
}

TECHNIQUE lockon_shadows
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(COMPILE_VERTEX_SHADER(lk_shadow_vs()))
		SetPixelShader(NULL);
		SetGeometryShader(NULL);
		SetDepthStencilState(shadowmapDepthState, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(modelShadowRasterizerState);
	}
}
