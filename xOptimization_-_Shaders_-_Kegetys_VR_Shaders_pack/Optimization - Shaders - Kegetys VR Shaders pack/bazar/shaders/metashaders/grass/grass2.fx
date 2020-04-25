#include "../inc/samplers.hlsl"
#include "common/states11.hlsl"
#include "common/colorTransform.hlsl"
#include "common/packing.hlsl"
#include "common/random.hlsl"
#include "perlin.hlsl"
#include "noise/noise2D.hlsl"
#include "../terrain/inc/ClipFrustum.hlsl"
#include "../terrain/inc/vortexUtils.hlsl"
#include "../terrain/inc/windUtils.hlsl"

#include "../../deferred/_HMD.hlsl"

#ifdef USE_DCS_DEFERRED
#include "common/stencil.hlsl"
#endif

// #define DEBUG_NO_UNIQUE_ROTATION
// #define DEBUG_NO_COLOR_JITTER
// #define DEBUG_DRAW_BLADE_ID
// #define DEBUG_DRAW_LOD_ID
// #define DEBUG_DRAW_LOD_FACTOR
// #define DEBUG_FIXED_COLOR
// #define DEBUG_BLADE_ID

#define SURFACE_NORMAL
#define SURFACE_OCCLUSION
#define HEIGHT_COMPENSATION
// #define SMOOTH_LODS_TRANSITION

#ifdef DEBUG_DRAW_BLADE_ID
#define DEBUG_BLADE_ID
#endif
#ifdef DEBUG_DRAW_LOD_ID
#define DEBUG_LOD_ID
#endif
#ifdef DEBUG_DRAW_LOD_FACTOR
#define DEBUG_LOD_FACTOR
#endif

#ifdef EDGE

// params for wind
//float2 windTransform;

// fog fog
#define FOG_ENABLE
#define GRASS_FOG

float4	SharedParams_FogColor;
float4	SharedParams_FogCoefficients;
float	SharedParams_cameraHeight;
float4	SharedParams_FogDistances;

#include "../inc/fog.hlsl"

#endif

static const float PI2 = 6.2831853071795;

#define BLADE_SEGMENTS	3

Texture2D<float> heightMap;//карта высот
Texture2D<uint2> Heightmap_NoL_SDID;
Texture2D colorMap;			// xyz - grass color, w - grass height

float4x4 heightMapProjInv;
float4x4 VP;
float4x4 View;

float TerrainContext_seaLevel;
float4	origin;		// xyz -origin, w - time
#define time	origin.w // cur time

float3	cameraPos;	// camera pos in origin space
int		LODsNumber;		// количество лодов

float	fft_FarNoiseTilingInv;
float2	fft_FarNoiseOrigin;

float2	radiusLODMinMax;
float2	grassDiameterCellSize;
float2	grassHeightHalfWidth;
float4	jitterColorHeight;		// x - color jitter сoef, yz - height jitter сoef, w - max value for shadow
float4	grassBendInclinationJitter; // x - grass blade bend jitter, y - grass blade inclination jitter, z - grass cell bend jitter, w - grass cell inclination jitter

#define maxShadownItensity	jitterColorHeight.w 	// максимальная интесивность затенения основания травинки
#define grassDiameter		grassDiameterCellSize.x	//диаметр круга травы, в метрах
#define grassCellSize		grassDiameterCellSize.y	//размер ячейки травы
#define grassHeight			grassHeightHalfWidth.x	//масимальная средняя высота травинки, м
#define grassHalfWidth		grassHeightHalfWidth.y	// половина ширины травинки

//float4 windAndWindOffset; // xy - wind, zw - wind offset

static const float AORange = 0.5;

//----------------------------------------------------------------------------------------------------------------------------------------------------

float noise2D_2(float2 xy)
{
	// return hash12(xy);//better distribution, cheaper, but glitched...

	xy -= floor(xy / 289.0) * 289.0;
	xy += float2(223.35734, 550.56781);
	xy *= xy;
	float p = xy.x * xy.y;
	return frac(dot(frac(p * float4(0.00000012, 0.00000543, 0.00000192, 0.00000423)), 0.25) * 1283.679412683);
}

float2 FastVectorClamp(float2 v, float clampLength)
{
	precise float normFactor = saturate(clampLength * rsqrt(dot(v, v)));
	return v * normFactor;
}

float4 getGrassColor(float2 uv)
{
	float4 color = colorMap.SampleLevel(ClampPointSampler, uv, 0);

#ifdef DEBUG_FIXED_COLOR
	const float3 grassFixedColor = float3(113/255.0, 118/250.0, 52/255.0);
	color.rgb = lerp(grassFixedColor, 0.6, 0.2);
#endif
	
	return color;
}

#include "grass2_preprocess.hlsl"

//----------------------------------------------------------------------------------------------------------------------------------------------------
struct VS_OUTPUT
{
	float3 pos				: POSITION0;// xyz - grass cell pos
	float4 color			: COLOR0;	// xyz - color, w - grass height
	float4 inclinationBend	: COLOR1;	// xy - inclination sin(x,z axis), zw - bend
#ifdef HEIGHT_COMPENSATION
	float2 heightGradients	: COLOR2;	// height of grass quad corners
#endif
#ifdef SURFACE_NORMAL
	float NoL				: COLOR3;
#endif
};

struct HS_CONST_OUTPUT
{
	//generate gass points. значение SV_TessFactor / количество точек на выходе тесселятора для point:
	// (0.0; 0.5) - 1; [0.5; 1.5) - 2; [1.5; 2.5) - 3, и т.д.
	float edges[2]			: SV_TessFactor;
	float4 inclinationBend	: TEXCOORD1; // xy - inclination sin(x,z axis), zw - bend
	float3 params			: TEXCOORD2;		// x - blade thickness scale, far is more fat, y - color jittering between blades, z - height scale by distance
#ifdef DEBUG_LOD_ID
	uint lodId				: TEXCOORD3;
#endif
	float lodFactor			: TEXCOORD4;
};

struct HS_OUTPUT
{
	float3 pos  			: POSITION0;	// pos
	float4 color			: COLOR0;		// xyz - color, w - grass height
#ifdef HEIGHT_COMPENSATION
	float2 heightGradients	: COLOR1;	// height of grass quad corners
#endif
#ifdef SURFACE_NORMAL
	float NoL				: COLOR3;
#endif
};

struct DS_OUTPUT
{
	float4 pos	 			: POSITION0;	// xyz - pos, w - lodFactor (scale factor of grass thickness by distance)
	float4 color 			: COLOR0;		// xyz - color with jitter, w - height scale by distance
	float4 inclinationBend	: TEXCOORD1; // xy - inclination sin(x,z axis), zw - bend
	float2 params			: TEXCOORD0;	// x - random, y - reduce height, by distance 
#ifdef SURFACE_NORMAL
	float NoL				: COLOR3;
#endif
#ifdef DEBUG_BLADE_ID
	uint bladeId			: TEXCOORD2;
#endif
#ifdef DEBUG_LOD_ID
	uint lodId				: TEXCOORD3;
#endif
#ifdef DEBUG_LOD_FACTOR
	float lodFactor			: TEXCOORD4;
#endif
};

struct GS_OUTPUT
{
	float4 pos				: SV_POSITION0;	// projected pos
	float4 projPos			: TEXCOORD0;// projected pos for defered pixel shader
	float3 color			: COLOR0;		// rgb-color, w - gradient
#ifdef SURFACE_NORMAL
	float NoL				: COLOR3;
#endif
#ifdef USE_DCS_DEFERRED
	float3 norm				: NORMAL0;		// grass normal for defered
#endif
#ifdef DEBUG_BLADE_ID
	uint bladeId			: TEXCOORD1;
#endif
#ifdef DEBUG_LOD_ID
	uint lodId				: TEXCOORD2;
#endif
#ifdef DEBUG_LOD_FACTOR
	float lodFactor			: TEXCOORD3;
#endif
};

//----------------------------------------------------------------------------------------------------------------------------------------------------

VS_OUTPUT vs_instance(in uint instanceId : SV_INSTANCEID)
{
	GrassInfo i = grassPosBufferRead[instanceId];

	VS_OUTPUT o;
	o.color = i.grassColor;
	o.pos.xyz = i.grassPos.xyz;
#ifdef SURFACE_NORMAL
	o.NoL = i.NoL;
#endif
	o.inclinationBend = i.inclinationBend;
#ifdef HEIGHT_COMPENSATION
	o.heightGradients = i.heightGradients;
#endif
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
HS_OUTPUT hs(InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	o.color = ip[0].color;
#ifdef SURFACE_NORMAL
	o.NoL = ip[0].NoL;
#endif
#ifdef HEIGHT_COMPENSATION
	o.heightGradients = ip[0].heightGradients;
#endif
	return o;
}

//----------------------------------------------------------------------------------------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant(InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID)
{
	HS_CONST_OUTPUT o;

	float distToCamera = length(ip[0].pos.xyz - cameraPos.xyz);
	// float invLODDist = 1.0 - smoothstep(radiusLODMinMax.x, radiusLODMinMax.y, distToCamera);
	float invLODDist = 1.0 - saturate((distToCamera - radiusLODMinMax.x) / (radiusLODMinMax.y-radiusLODMinMax.x) );
	float lodID = 0.50001 + LODsNumber*invLODDist;

#ifdef DEBUG_LOD_ID
	o.lodId = lodID - 0.5;
	// o.lodId = lodID;
#endif
// #ifdef DEBUG_LOD_FACTOR
	o.lodFactor = frac(lodID - 0.5);
	// o.lodFactor = frac(lodID);
// #endif

	float distLODRangeInv = min(1, (distToCamera*2.0 / grassDiameter));
	
	// blade thickness scale, far is more fat
	const float koefOfThickness = 8.0; // move to shader params?
	o.params.x = (1.0 + koefOfThickness*distLODRangeInv)*grassHalfWidth;

	// color jitter between blades, far have less jitter for minimaze grass visible end and LOD changing
	o.params.y = jitterColorHeight.x*invLODDist;
	o.params.z = 1 - distLODRangeInv; // height scale by distance

#ifdef DEBUG_NO_COLOR_JITTER
	o.params.y = 0;
#endif

	//generate gass points. значение SV_TessFactor / количество точек на выходе тесселятора для point:
	// (0.0; 0.5) - 1; [0.5; 1.5) - 2; [1.5; 2.5) - 3, и т.д.
	o.edges[1] = lodID;
	o.edges[0] = 1;

	// xy - inclination
	o.inclinationBend = ip[0].inclinationBend;
#ifdef DEBUG_NO_UNIQUE_ROTATION
	o.inclinationBend = 0;
#endif

	return o;
}

//----------------------------------------------------------------------------------------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds(HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch)
{
	DS_OUTPUT o;

	float bladesNumber = input.edges[1]*input.edges[0]; // grass blade number in cell
	uint bladeId = UV.x*input.edges[1] + UV.y*bladesNumber + 0.50001;//id травинки

	float originStep = 64;
	float2 rndPos = patch[0].pos.xz / originStep;
	rndPos = (rndPos - floor(rndPos)) * originStep;//рандом зацикленный через каждые 64м
	float rand = noise2D_2(rndPos + bladeId*14.1937528426137);//random

	// add random offset from grass cell center in range [-0.5;+0.5] of cell size (grass generated all lie within a single cell)
	float3 rnd = noise3(float3(rand*14.6235, rand*23.1347, (rand + 0.7243)*9.52517), 1758.937545312382); // noise is in [0;1) range

	// random offset on xz	for generated in HShader blade
	o.pos.xyz = patch[0].pos.xyz;

	float2 posInQuad = (rnd.xy - 0.5)*grassCellSize*1.05; // jitter pos inside grass cell

#ifdef HEIGHT_COMPENSATION
	float2 heightGrad = patch[0].heightGradients;
	o.pos.y += dot(heightGrad, rnd.xy - 0.5);
#endif
	o.pos.xz += posInQuad; // jitter pos inside grass cell

	o.pos.w = input.params.x; // scale factor of grass thickness

#ifdef SMOOTH_LODS_TRANSITION
	// if(bladesNumber>0.999 && (bladesNumber - 0.50001 <= bladeId))
	if((bladesNumber - 0.5000 <= bladeId))
		o.pos.w *=input.lodFactor;
	// o.pos.w *= lerp(1, input.lodFactor, step(bladesNumber - 0.50001, bladeId));
#endif

	o.color = patch[0].color;
	o.color.rg = saturate(o.color.rg + max(patch[0].color.r, patch[0].color.g) * input.params.y * rand); // разброс оттенков травинок теплее/холоднее + уменьшаем по яркости и по дальности
	o.color.a *= input.params.z; // height scale by distance

	o.inclinationBend = input.inclinationBend;
	o.params.x = rand;
	o.params.y = input.params.z;	// reduce height, by distance;

#ifdef SURFACE_NORMAL
	o.NoL = patch[0].NoL;
#endif
#ifdef DEBUG_BLADE_ID
	o.bladeId = bladeId % 8;
#endif
#ifdef DEBUG_LOD_ID
	o.lodId = input.lodId % 8;
#endif
#ifdef DEBUG_LOD_FACTOR
	o.lodFactor = input.lodFactor;
#endif

	return o;
}

// GEOMETRY SHADER------------------------------------------------------------------------------------------------------------------------------------
[maxvertexcount(BLADE_SEGMENTS * 2 + 1)]
void gs(point DS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

#ifdef DEBUG_BLADE_ID
	o.bladeId = i[0].bladeId;
#endif
#ifdef DEBUG_LOD_ID
	o.lodId = i[0].lodId;
#endif
#ifdef DEBUG_LOD_FACTOR
	o.lodFactor = i[0].lodFactor;
#endif

#ifdef SURFACE_NORMAL
	o.NoL = i[0].NoL;
#endif

	float RAND = i[0].params.x;		// random
	float RAND2 = noise1D(RAND);	// random2
	float DIST_GRAD = i[0].params.y;// distance gradient

	float2 bendJitter = float2(lerp(-grassBendInclinationJitter.x, grassBendInclinationJitter.x, RAND), lerp(-grassBendInclinationJitter.x, grassBendInclinationJitter.x, RAND2));
	float2 inclinationJitter = float2(lerp(-grassBendInclinationJitter.y, grassBendInclinationJitter.y, RAND), lerp(-grassBendInclinationJitter.y, grassBendInclinationJitter.y, RAND2));

#ifdef DEBUG_NO_UNIQUE_ROTATION
	inclinationJitter = inclinationJitter = 0;
#endif

	// bend
	float2 bendSinXZ = i[0].inclinationBend.zw + bendJitter;
	bendSinXZ /= (max(BLADE_SEGMENTS - 1, 1));		// SEGMENTS - 1
	float2 bendCosXZ = float2(sqrt(1 - bendSinXZ.x*bendSinXZ.x), sqrt(1 - bendSinXZ.y*bendSinXZ.y));
	float2x2 bendRotateX = { bendCosXZ.x, -bendSinXZ.x, bendSinXZ.x, bendCosXZ.x };
	float2x2 bendRotateZ = { bendCosXZ.y, -bendSinXZ.y, bendSinXZ.y, bendCosXZ.y };

	// grassLength
	float grassLengthWithJitter = i[0].color.w*(jitterColorHeight.y + jitterColorHeight.z*RAND);

	// per blade, generate random rotation aroun (0,1,0) axis
	float2 grassBladeOrientation;
	sincos(PI2*RAND, grassBladeOrientation.x, grassBladeOrientation.y);

#ifdef DEBUG_NO_UNIQUE_ROTATION
	grassBladeOrientation = float2(0.0, 1.0);
#endif

	// make blade more thin for grass with small height
	float bladeHeight = i[0].color.w;
	float thinDistK = saturate(2.0*bladeHeight + 0.1);

	const float invSegments = 1.0 / BLADE_SEGMENTS;

	float2 grassWidthWithOrientation = grassBladeOrientation * (i[0].pos.w * DIST_GRAD * thinDistK * invSegments);

	// inclination
	const float maxInclination = 0.98;//clamp lenght by 0.98
	float2 inclinationXZ = i[0].inclinationBend.xy;
	float2 inclinationWithJitterXZ = FastVectorClamp(inclinationXZ + inclinationJitter, maxInclination);

	float inclinationY = sqrt(1.0 - dot(inclinationWithJitterXZ, inclinationWithJitterXZ)); // sqrt( 1- (sin(aX)^2 + sin(aZ)^2))
	float3 grassVector = float3(inclinationWithJitterXZ.x, inclinationY, inclinationWithJitterXZ.y) * (grassLengthWithJitter * invSegments);

	// grass segments (using triangle strip)
	{
		float4 curPos = float4(i[0].pos.xyz, 1);
		float3 perSegmentVector = grassVector;
		float2 perSegmentWidth = grassWidthWithOrientation;
		float  shadowIntensity = lerp(1.0, maxShadownItensity, DIST_GRAD); // reduce grass 'shadow' for bigger distance
		o.color = i[0].color.rgb;

#ifdef USE_DCS_DEFERRED

	#ifdef SURFACE_OCCLUSION
		float heightFactor = 0.1 + 0.9*saturate(grassLengthWithJitter / grassHeight);
		float aorange = heightFactor * AORange * DIST_GRAD;
		float perSegmentAO = invSegments * aorange * shadowIntensity;
	#else
		const float aorange = 0.0;
	#endif

		o.norm = float3(-grassBladeOrientation.y, 1-shadowIntensity*aorange, grassBladeOrientation.x);
		o.norm.xz = o.norm.xz*0.5+0.5;

#else // forward shading

	#ifdef SURFACE_OCCLUSION
		float3 colorJitterPerSegment = (1.0 - shadowIntensity)*invSegments*i[0].color.rgb;
		o.color.rgb *= shadowIntensity;
	#endif

#endif

		float2 curOffsetXZ = BLADE_SEGMENTS * perSegmentWidth;

		[unroll]
		for (float segmentCount = BLADE_SEGMENTS; segmentCount >= 1.0; segmentCount -= 1.0)
		{
			curOffsetXZ -= perSegmentWidth;
			float4 vertexPos = curPos;
			vertexPos.xz -= curOffsetXZ; // xz offset by grass orientation with blade thickness

		#if defined(USE_DCS_DEFERRED) && defined(SURFACE_OCCLUSION)
			o.norm.y += perSegmentAO;
		#endif

			o.pos = o.projPos = mul(vertexPos, VP);
			outputStream.Append(o); // vertex 0, 2, 4, ...

			vertexPos.xz += 2.0*curOffsetXZ;
			o.pos = o.projPos = mul(vertexPos, VP);
			outputStream.Append(o); // vertex 1, 3, 5, ...

			curPos.xyz += perSegmentVector;

		#if !defined(USE_DCS_DEFERRED) && defined(SURFACE_OCCLUSION)
			o.color += colorJitterPerSegment;
		#endif

			// apply bend
			perSegmentVector.xy = mul(perSegmentVector.xy, bendRotateX);
			perSegmentVector.zy = mul(perSegmentVector.zy, bendRotateZ);
		}

		// grass tip
		{
		#ifdef USE_DCS_DEFERRED
			o.norm.y = 1.0;
		#endif
			o.pos = o.projPos = mul(curPos, VP);
			outputStream.Append(o); // tip vertex
			outputStream.RestartStrip();
		}
	}
}

#if defined(DEBUG_DRAW_BLADE_ID) || defined(DEBUG_DRAW_LOD_ID)
static const float4 dbgColors[] =
{
	float4(1, 0, 0, 1),
	float4(0, 1, 0, 1),
	float4(0, 0, 1, 1),
	float4(1, 1, 0, 1),
	float4(0, 1, 1, 1),
	float4(1, 0, 1, 1),
	float4(0, 0, 0, 1),
	float4(1, 1, 1, 1),
};
#endif

#ifdef USE_DCS_DEFERRED

#include "deferred/GBuffer.hlsl"

GBuffer BuildGBufferGrass(float2 sv_pos_xy, float4 color, float2 normal, float nHeight, float NoL, float4 projPos, bool coverage) 
{
	GBuffer o;
	float3 ec = encodeColorYCC(color.xyz);
	o.target0 = float4(normal.xy, 0, color.a);
	o.target1 = float4(ec.x, nHeight, 0, color.a);
	o.target2 = float4(ec.yz, 0, color.a);
#if USE_COVERAGE
	o.target3 = float4(NoL, packFloat1Bit(0, coverage), 0, 0);
#else
	o.target3 = float4(NoL, 0, 0, 0);
#endif
#if USE_SEPARATE_AO
	//o.target4 = float4(1, 0, 0, color.a);
#endif
#if USE_VELOCITY_MAP
	o.target5 = float4(calcVelocityMapStatic(projPos), 0, color.a);
#endif
	return o;
}


#if ENABLE_SIMPLE_GRASS
// Only write color for grass to save on bandwidth
// TODO: could change ComposeFoliageSample to not use the others (currently there is a bit of a see-through effect)
struct GColor
{
	float2 target1 : SV_Target1;
	float2 target2 : SV_Target2;
};
GColor ps(in GS_OUTPUT i): SV_TARGET1
{
	GColor o;
	float3 ec = encodeColorYCC(i.color.xyz * max(0.5, i.NoL));
	o.target1 = float2(ec.x, i.norm.y);
	o.target2 = ec.yz;
	return o;
}
#else

GBuffer ps(in GS_OUTPUT i
#if USE_COVERAGE
	, uint sv_coverage : SV_Coverage
#endif
)
{
#ifdef DEBUG_DRAW_BLADE_ID
	i.color.rgb = dbgColors[i.bladeId];
#endif
#ifdef DEBUG_DRAW_LOD_ID
	i.color.rgb = dbgColors[i.lodId];
#endif
#ifdef DEBUG_DRAW_LOD_FACTOR
	i.color.rgb = i.lodFactor;
	i.color.rgb = (i.lodFactor*0.5 + 0.5) * dbgColors[i.bladeId];
#endif

	bool coverage = 1;
#if USE_COVERAGE
	coverage = sv_coverage != COVERAGE_MASK;
#endif

#ifdef SURFACE_NORMAL
	return BuildGBufferGrass(i.pos.xy, float4(i.color.rgb, 1), i.norm.xz, i.norm.y, i.NoL, i.projPos, coverage);
#else
	return BuildGBufferGrass(i.pos.xy, float4(i.color.rgb, 1), i.norm.xz, i.norm.y, 1, i.projPos, coverage);
#endif
}
#endif

#else //if not deferred

float4 ps(in GS_OUTPUT i): SV_TARGET0
{
#ifdef DEBUG_DRAW_BLADE_ID
	return dbgColors[i.bladeId];
#endif
#ifdef DEBUG_DRAW_LOD_ID
	return dbgColors[i.lodId];
#endif

	return float4(i.color.xyz, 0.00392157); // 1/255
}

#endif

#ifdef USE_DCS_DEFERRED
DepthStencilState Grass_DepthStencilState
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = DEPTH_FUNC;
	WRITE_COMPOSITION_TYPE_TO_STENCIL;
};
#endif

technique11 grassClearTech
{
	pass grass
	{
		SetComputeShader(CompileShader(cs_5_0, grassClearProc()));
	}
};

technique11 grassPrepareCullDataTech
{
	pass grass
	{
		SetComputeShader(CompileShader(cs_5_0, grassPrepareCullDataProc()));
	}
};

technique11 grassGPUGenetatesPosTech
{
	pass grass
	{
		SetComputeShader(CompileShader(cs_5_0, grassCullingWithGeneratedPosProc()));
	}
};

technique11 grassGPUTech
{
	pass grass
	{
		SetVertexShader(CompileShader(vs_5_0, vs_instance()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_5_0, gs()));
		SetPixelShader(CompileShader(ps_5_0, ps()));

		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#ifdef USE_DCS_DEFERRED
		SetDepthStencilState(Grass_DepthStencilState, STENCIL_COMPOSITION_GRASS);
#else
		SetDepthStencilState(enableDepthBuffer, 0xFFFFFFFF);
#endif
		SetRasterizerState(cullNone);
	}
}
