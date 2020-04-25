#include "../inc/samplers.hlsl"
#include "common/states11.hlsl"
#include "common/colorTransform.hlsl"
#include "perlin.hlsl"
#include "noise/noise2D.hlsl"
#include "../terrain/inc/ClipFrustum.hlsl"

#ifdef USE_DCS_DEFERRED
	#include "common/stencil.hlsl"
	#define GRASS_SHADING
#endif

#ifdef EDGE

// params for wind
float	SharedParamsWindSpeed;
float	fft_FarNoiseTiling;
float2	fft_FarNoiseOrigin;
float3	SharedParamsWindDirection;
Texture2D FFTMap;

// waves target
//#include "../terrain/inc/waveMapUtils.hlsl"
#include "../terrain/inc/vortexUtils.hlsl"

// fog fog
#ifdef METASHADER
	#include "../terrain/inc/SharedParams.hlsl"
	Texture2D irendercontext::SkyMap;
#else

	#define FOG_ENABLE
	#define GRASS_FOG

	float4	SharedParams_FogColor;
	float4	SharedParams_FogCoefficients;
	float	SharedParams_cameraHeight;
	float4	SharedParams_FogDistances;

	#include "../inc/fog.hlsl"

#endif
#endif

float4	FrustumPlanes[6];

#ifndef EDGE
#define ADD_WIND
#endif

// #define DEBUG_NO_SPREAD
// #define DEBUG_NO_UNIQUE_ROTATION
// #define DEBUG_NO_COLOR_JITTER
// #define DEBUG_BLADE_ID
// #define DEBUG_LOD_ID

// #define DEBUG_DRAW_BLADE_ID
// #define DEBUG_DRAW_LOD_ID

static const float PI2 = 6.2831853071795;
#define BLADE_SEGMENTS	2
#define SURFACE_OCCLUSION

float4	lodRadiusGrassDiameterSize;
float4	grassBladeParams;
uint4	intParams;	//zw - unused

float3 camPosAligned;
float3 centerOffset;
float4 gridOffset;//xy-выравнивание сетки по квадратам; zw-сдвиг симплекс шума для ветра

Texture2D<float> heightMap;//карта высот
Texture2D colorMap;

float4x4 heightMapProj;
float4x4 View;
float4x4 VP;

float4	origin;	//xyz -origin, w - time
float3	cameraPos;

float3 sunDir;
float3 sunDiffuse;

float3	wind;//sin, cos, wind power, quadSize

#define radiusMin		lodRadiusGrassDiameterSize.x //радиус ближнего лода
#define radiusMax		lodRadiusGrassDiameterSize.y //радиус дальнего лода
#define grassDiameter	lodRadiusGrassDiameterSize.z //диаметр круга травы, в метрах
#define quadSize		lodRadiusGrassDiameterSize.w //размер ячейки травы

#define grassHalfWidth	grassBladeParams.x //половина ширины травинки, м
#define grassHeight		grassBladeParams.y //масимальная средняя высота травинки, м
#define grassSize		grassBladeParams.xy
#define bendDistMax		grassBladeParams.z //максимальная проекция наклона травинки в сторону, м
// #define pointSpread		grassBladeParams.w //разброс травинок одной ячейки, как бы метры
#define pointSpread		quadSize*2 //разброс травинок одной ячейки, как бы метры

#define lodsCount		intParams.x //количество лодов
// #define lodsCount		0.5 //количество лодов

#define time			origin.w
#define windPower		wind.z  //мощность ветра[0;1]
#define windOffset		gridOffset.zw

#ifdef DEBUG_NO_SPREAD
	#undef pointSpread
	#define pointSpread 0.0
#endif

#ifdef DEBUG_DRAW_BLADE_ID
	#define DEBUG_BLADE_ID
#endif
#ifdef DEBUG_DRAW_LOD_ID
	#define DEBUG_LOD_ID
#endif

static const float	lodRange = radiusMax - radiusMin;
static const float	bladeSegments = BLADE_SEGMENTS;

struct VS_OUTPUT
{
	float3 pos	: POSITION0;
	float4 color: COLOR0;//color, grass height
};

struct HS_CONST_OUTPUT
{
	float edges[2] : SV_TessFactor;
	float4 lodParam: TEXCOORD1;
	float4 params:	 TEXCOORD2;
#ifdef DEBUG_LOD_ID
	uint lodId: TEXCOORD3;
#endif
};

struct HS_OUTPUT
{
	float3 pos  : POSITION0;
	float4 color: COLOR0;//color, grass height
};

struct DS_OUTPUT
{
	float4 pos	 : POSITION0;//pos, lodFactor
	float4 color : COLOR0;//clr, height
	float4 params: TEXCOORD0;//
#ifdef DEBUG_BLADE_ID
	uint bladeId:TEXCOORD2;
#endif
#ifdef DEBUG_LOD_ID
	uint lodId:TEXCOORD3;
#endif
};

struct GS_OUTPUT
{
	float4 pos  : SV_POSITION0;
	float4 projPos  : TEXCOORD0;
	float3 color: COLOR0;//rgb-color, w - gradient
#ifdef GRASS_SHADING
	// float3 vPos: TEXCOORD0;
	float3 norm: NORMAL0;
#endif
#ifdef DEBUG_BLADE_ID
	uint bladeId: TEXCOORD2;
#endif
#ifdef DEBUG_LOD_ID
	uint lodId	: TEXCOORD3;
#endif
};

VS_OUTPUT vsTest(in float2 pos: POSITION0)
{
	VS_OUTPUT o;
	o.pos.xyz = float3(pos.x, 0, pos.y) - origin.xyz;
	return o;
}

float2 getGrassUV(float2 posW)
{
#ifdef EDGE
	float2 UV = mul(heightMapProj, float4(posW.x, 0, posW.y, 1)).xy*0.5 + 0.5;
#else
	float2 UV = mul(float4(posW.x, 0, posW.y, 1), heightMapProj).xy*0.5 + 0.5;
#endif
	UV.y = 1 - UV.y;

	return UV;
}

float4 getGrassColor(float2 uv)
{
	float w, h;
	colorMap.GetDimensions(w, h);
	float dx = 1.0 / w;
	float dy = 1.0 / h;

	float2 kernelUV[9] = {
		float2(-dx, -dy), float2(0, -dy), float2(dx, -dy),
		float2(-dx, 0), float2(0, 0), float2(dx, 0),
		float2(-dx, dy), float2(0, dy), float2(dx, dy) };

	float minHeight = 1.0;
	float epsilon = 0.01;
	for (int i = 0; i < 9; ++i)
	{
		float height = colorMap.SampleLevel(ClampPointSampler, uv + kernelUV[i], 0).a;
		minHeight = min(minHeight, height);
	}

	float4 color = colorMap.SampleLevel(ClampPointSampler, uv, 0);
		color.a = minHeight <= epsilon ? 0.0 : color.a;
	return color;
}

//----------------------------------------------------------------------------------------------------------------------------------------------------
Buffer<float2>	inputCullingData; // contain: xy - pos.xz
uint	culledSector[256]; // cpu culled value (0 = don't need render)

struct grassInfo
{
	float4	grassPos;
	float4	grassColor;
};

RWStructuredBuffer<grassInfo> grassPosBuffer;
StructuredBuffer<grassInfo> grassPosBufferRead;

RWBuffer<uint> instanceIndirectDrawBuffer;

uint	boundsNumber;
float	boundRingRadius;
float	grassCellRadius;

float2	grassCenterOffset;
float	grassOffsetInGroup;

//----------------------------------------------------------------------------------------------------------------------------------------------------

[numthreads(1, 1, 1)]
void grassClearProc(uint3 groupId : SV_GroupID, uint3 groupThreadID : SV_GroupThreadID)
{
	instanceIndirectDrawBuffer[0] = 1;
	instanceIndirectDrawBuffer[1] = 0;
	instanceIndirectDrawBuffer[2] = 0;
	instanceIndirectDrawBuffer[3] = 0;
}

// have limit DX11 CS 5.0 of 1024 threads, compensation through dispatch(x, y, 1)
[numthreads(16, 64/*grass number in quade side*/, 1)]
void grassCullingWithGeneratedPosProc(uint3 groupId : SV_GroupID, uint3 groupThreadID : SV_GroupThreadID, uint3 dispatchedID : SV_DispatchThreadID)
{
	//                 dispatch       thread
	uint grassQuadID = groupId.x*16 + groupThreadID.x;
	
	if (grassQuadID >= boundsNumber)
		return;

	if (culledSector[grassQuadID] == 0)
		return;

	float2 baseOffset = inputCullingData[grassQuadID].xy + cameraPos.xz;
	baseOffset -= grassOffsetInGroup*32.0; // offset by half quad size, change if group size changed

	float4 pos;
	pos.w = 1.0;
	pos.y = 0.0;

	uint pointIndex = 0;

	// 
	float dx = groupThreadID.y;
	pos.x = baseOffset.x + dx*grassOffsetInGroup;
	pos.z = baseOffset.y + groupId.y*grassOffsetInGroup;

	float2 UV = getGrassUV(pos.xz - gridOffset.xy);
	pos.y = heightMap.SampleLevel(ClampPointSampler, UV, 0).r;

	if (!IsSphereInFrustum(pos.xyz, grassCellRadius, FrustumPlanes))
		return;

	if (distance(pos.xyz, cameraPos.xyz) > boundRingRadius)
		return;

	float4 color = getGrassColor(UV);
	if (color.a < 0.01)
		return;

	InterlockedAdd(instanceIndirectDrawBuffer[1], 1, pointIndex);

#ifdef EDGE
	float4 NDCposition = mul(float4(pos.xyz, 1), VP);
	fogApply(cameraPos.xyz, pos.xyz, NDCposition, color.rgb);
#endif

	pos.xyz -= cameraPos.xyz;
	grassPosBuffer[pointIndex].grassPos = pos;
	grassPosBuffer[pointIndex].grassColor = color;
}

VS_OUTPUT vs(in float2 pos: POSITION0)
{
	VS_OUTPUT o;
	float2 posW = pos.xy*quadSize;
	o.pos.xz = posW;
	posW += cameraPos.xz - gridOffset.xy;
	
	float2 UV = getGrassUV(posW);
	float posY = heightMap.SampleLevel(ClampPointSampler, UV, 0).r;
	o.pos.y = posY - cameraPos.y;

	float4 color = getGrassColor(UV);
	o.color = color;

	return o;
}

VS_OUTPUT vs_instance(in uint instanceId : SV_INSTANCEID)
{
	VS_OUTPUT o;

	o.color = grassPosBufferRead[instanceId].grassColor;
	o.pos.xyz = grassPosBufferRead[instanceId].grassPos.xyz;

	return o;
}

// HULL SHADER ---------------------------------------------------------------------

float windAmount2D(float2 uv)
{
	//float result = 0.0f;
	//result = (snoise(uv)*0.5+0.5);
	//result += (snoise(uv*2)*0.5+0.5)*0.25;
	return snoise(uv)*0.5+0.5;
}

HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 

	float distReal = length(ip[0].pos.xyz+centerOffset);
	float dist = max(0, distReal - radiusMin);//задаем минимальный радиус ближнего лода
	float nDist = min(1, (dist/lodRange));
	
	float lodId = floor(lodsCount*(1-nDist) + 0.500001); // lodId
#ifdef DEBUG_LOD_ID
	o.lodId = lodId;
#endif

	o.lodParam.x = frac(lodsCount*nDist + 0.5);//нормализованный параметр расстояния от ближней до дальней границы лода
	
	//относительное расстояние до конца круга травы,выглядит норм, если трава всегда находится в нуле, при смещении камеры вперед не подходит
	//o.lodParam.y = 2*distReal/grassDiameter;
	float distGradWorld = 2*distReal / grassDiameter;//от центра камеры до реального положения вершины
	o.lodParam.y = saturate((distGradWorld-0.2)*1.25);
	
	//относительное расстояние до конца круга травы, всегда считаем от ее центра
	float distGrad = 2 * length(ip[0].pos.xyz) / grassDiameter;
	// float distGrad = 2*distance(ip[0].pos.xyz, float3(0, origin.y, 0)) / grassDiameter;
	o.lodParam.z = max(0,distGrad-0.5)*grassHeight; //height factor	
	
	float nHeightFactor = saturate(-ip[0].pos.y/100);
	o.params.x = 1 + max(0, lodsCount - lodId + o.lodParam.x) + 20 * nHeightFactor * nHeightFactor;//scale factor
	o.params.y = 0.20*max(ip[0].color.r,ip[0].color.g)*(1-o.lodParam.y*o.lodParam.y);//color factor
#ifdef DEBUG_NO_COLOR_JITTER
	o.params.y = 0;
#endif

	//значение SV_TessFactor / количество точек на выходе тесселятора для point:
	// (0.0; 0.5) - 1
	// [0.5; 1.5) - 2
	// [1.5; 2.5) - 3, и т.д.
	o.edges[1] = (exp2(lodId)-0.5001) * step(0.005, ip[0].color.w);//2^lod травинок, либо 0 если на текстуре травы нет
	o.edges[0] = 1; // detail factor//TODO: попробовать поиграться с фактором, пересчитать bladeId в DS
	
	o.lodParam.x = 1 - o.lodParam.x*o.lodParam.x;
	
	//WIND ANIMATION -------------------------------------------
#ifdef ADD_WIND //шатаем траву
	const float timeFactor = 3;//скорость шевеления травы
	const float frec = 0.45;
	const float ampl = 1.0;

	int2 rndPos = fmod((ip[0].pos.xz + camPosAligned.xz)/quadSize, 10000.f);//XY, приведенные к целым пикселям, и зацикленные через каждые 10км, и 
	float minWindAmount = windPower*0.5;//минимальное отклонение травинки, чем выше сила ветра - тем больше
	
	float windAmount = windAmount2D( (rndPos.xy - windOffset) * lerp(0.06, 0.03, windPower) );
	//float windAmount = windAmount2D( (rndPos.xy - wind.xy*time*windSpeed*(1+0.4*windPower)) * lerp(0.06, 0.03, windPower) );
	o.lodParam.w = 1-0.6*windAmount*(0.8+0.2*windPower);//чем сильнее порыв ветра, тем ниже трава опускается

	o.params.zw = float2(sin(time*timeFactor + rndPos.x*frec), cos(time*timeFactor + rndPos.y*frec))*ampl*(0.4+1.1*windPower);//простое брожение травинок
	o.params.zw += wind.xy*lerp(minWindAmount, 1, windAmount)*(0.1+0.9*windPower)*grassHeight*10;//ветрюга		

#else
	o.params.zw = 0;
	o.lodParam.w = 1;
#endif
	//--------------------------------------------------------------

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
HS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	o.color = ip[0].color;

	return o;
}

float noise2D_2(float2 xy)
{
    xy -= floor(xy / 289.0) * 289.0;
    xy += float2(223.35734, 550.56781);
    xy *= xy;
    float p = xy.x * xy.y;
    
    return dot(frac(p * float4(0.00000012, 0.00000543, 0.00000192, 0.00000423)), 0.25);
}

// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	float BLADES_TOTAL		= input.edges[1]*input.edges[0];
	float LOD_GRAD			= input.lodParam.x;
	float DIST_GRAD_WORLD 	= input.lodParam.y; //от центра камеры до реального положения вершины
	float2 HEIGHT_FACTOR	= input.lodParam.zw; //на сколько нужно опустить ячейку травы с учетом дистанции
	float SCALE_FACTOR		= input.params.x;
	float COLOR_FACTOR		= input.params.y;
	float2 WIND_OFFSET		= input.params.zw;

	DS_OUTPUT o;
	o.pos.xyz = patch[0].pos.xyz;
	o.color = patch[0].color;

	uint bladeId = UV.x*input.edges[1] + UV.y*input.edges[0]*input.edges[1] + 0.50001;//id травинки
	int2 rndPos = fmod((o.pos.xz + camPosAligned.xz)/quadSize, 10000.f);//XY, приведенные к целым пикселям, и зацикленные через каждые 10км, и 
#ifdef DEBUG_NO_UNIQUE_ROTATION
	rndPos = 0;//XY, приведенные к целым пикселям, и зацикленные через каждые 10км, и 
#endif

	o.params.xy = WIND_OFFSET;
	o.params.z = noise2D_2(rndPos + bladeId*14.1937528426137);//random
	o.params.w = DIST_GRAD_WORLD;

	//разброс оттенков травинок теплее/холоднее + уменьшаем по яркости и по дальности
	o.color.rg += COLOR_FACTOR * (o.params.z-0.5);

	//придавливаем травку при сильных порывах ветра
	o.color.a *= HEIGHT_FACTOR.y;

	//при увеличении детализации, все новые травинки сужаются до 0, и расширяются до 1 к концу лода
	//сделано для визаульной плавности переключения лодов
	o.pos.w = SCALE_FACTOR * lerp(1, LOD_GRAD, step(BLADES_TOTAL/2, bladeId));//scale factor

	//опускаем только дальнюю границу круга чтобы ее сгладить
	o.pos.y -= HEIGHT_FACTOR.x;

	//компенсируем скачкообразное перемещение сетки
	o.pos.xz -= gridOffset.xy;

#ifdef DEBUG_BLADE_ID
	o.bladeId = bladeId;
#endif
#ifdef DEBUG_LOD_ID
	o.lodId = input.lodId;
#endif
	return o;
}

inline void addSegment(inout TriangleStream<GS_OUTPUT> outputStream, inout GS_OUTPUT o,
	in float3 startPos, in float height, in float2 offset, in float2 bendOffset
)
{
	float4 pos = float4(startPos, 1);
	pos.y += height;
	pos.xz += bendOffset;
	
	pos.xz += offset;
#ifdef GRASS_SHADING
	// o.vPos.xyz = pos.xyz;
#endif
	o.pos = o.projPos = mul(pos, VP);
	outputStream.Append(o);
	
	pos.xz -= 2*offset;
#ifdef GRASS_SHADING
	// o.vPos.xyz = pos.xyz;
#endif
	o.pos = o.projPos = mul(pos, VP);
	outputStream.Append(o);
}

float getBladeGradient(float height, float distCoef/*nDist*/)
{
// #undef SURFACE_OCCLUSION

#ifdef SURFACE_OCCLUSION
	// return lerp( 0.6+0.4*pow(min(1, height/0.30), 2), 1, distCoef);
	return lerp( 0.85+0.15*pow(min(1, height/0.30), 1), 1, distCoef);
#else
	return 1.0;
#endif
}

float3 noise3(float3 param)
{
	return frac(sin(param)*1758.937545312382);
}

//вывернуть нормаль на экран и спроецировать в пространство камеры
float3 projectNormalToViewSpace(in float3 norm, in float3 viewDir)
{
	// return mul(faceforward(norm, viewDir, norm), (float3x3)gView);
	return mul(faceforward(norm, viewDir, norm), (float3x3)View);
	// return faceforward(norm, viewDir, norm);
	// return mul(norm, View);
}

inline void generateBlade(float3 startPos, inout TriangleStream<GS_OUTPUT> outputStream, inout GS_OUTPUT o, 
						  float2 size, uniform float segments, float angle, float rand, float2 animOffset, float scale, float nDist, float3 color)
{
	// angle = 3.1415/2;
	const float bendDist = bendDistMax*scale*(0.2+0.8*(rand));//чем больше высота травинки тем больше изгиб
	const float animDist = 0.08*scale;//m
	
	float3 rnd = noise3(float3(rand*14.6235, rand*23.1347, (rand+0.7243)*9.52517));
	
	float spread = pointSpread*(0.3+0.7*rnd.x);//m

	startPos.xz += spread * (rnd.yz-0.5);

	float2 sc; sincos(angle, sc.x, sc.y);
	float2 offsetMax = size.x * sc * pow(size.y, 0.4);

	float2 bendVec = float2(-sc.y, sc.x) * bendDist;

	animOffset *= animDist;

	float distCoef = max(0.1, sqrt(nDist));
	
	//основание травы
	o.color.rgb = color*getBladeGradient(0, distCoef);
	
#ifdef GRASS_SHADING
	o.norm.xz = normalize(float2(-sc.y, sc.x));
	o.norm.y = 0;
#endif

	addSegment(outputStream, o, startPos, 0, offsetMax, 0);

	//сегменты
	[unroll]
	for(float ii=1.0f; ii<segments; ii+=1.0f)
	{
		float p = ii/segments;	//[0;1)
		o.color.rgb = color*getBladeGradient(size.y*p, distCoef);
	#ifdef GRASS_SHADING
		o.norm.y = p;
	#endif
		addSegment(outputStream, o, startPos,
			size.y*p, //высота
			offsetMax * pow(1-p, 0.3),//сдвиг точки вбок
			bendVec*pow(p,1.5) + animOffset*p//сдвиг точки в сторону изгиба
			);
	}

	//вершина травы
	o.color.rgb = color*getBladeGradient(size.y, distCoef);
	o.pos.xyz = startPos;
	o.pos.xz += bendVec + animOffset;
	o.pos.y += size.y;
#ifdef GRASS_SHADING
	o.norm.y = 1;
#endif
	o.pos = o.projPos = mul(float4(o.pos.xyz,1), VP);
	outputStream.Append(o);
	outputStream.RestartStrip();
}

[maxvertexcount(BLADE_SEGMENTS*2+1)]
void gs(point DS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	float2 ANIM_OFFSET 	= i[0].params.xy;
	float RAND			= i[0].params.z;
	float DIST_GRAD		= i[0].params.w;
	float heightScale 	= i[0].color.w;//высота травы
	float widthScale 	= i[0].pos.w;//1-передний план, N-самый дальний
	float RAND2 		= noise1D(RAND);//i[0].distGrad.y

	GS_OUTPUT o;
#ifdef DEBUG_BLADE_ID
	o.bladeId = i[0].bladeId;
#endif
#ifdef DEBUG_LOD_ID
	o.lodId = i[0].lodId;
#endif

#ifdef EDGE

	float dist = length(i[0].pos.xyz);
	const float maxWindDeformerDistance = 1000;
	const float windFlex = 0.1; // material::windFlex

	if (dist < maxWindDeformerDistance*windFlex)
	{
		float3 wind = float3(1, 0, 0);
		float windSpeed = SharedParamsWindSpeed;
		windSpeed = clamp(windSpeed / 20, 0, 1);

		float3 posW = i[0].pos.xyz + cameraPos.xyz;
		float3 pivot = posW.xyz; // TODO: make correct pivot

		float phase0 = TerrainContext_time * 10 * 8;

		float2 texcoord = pivot.xz / fft_FarNoiseTiling + fft_FarNoiseOrigin;
		//texcoord += sin(phase0)*0.01;
		float4 fftcolor = FFTMap.SampleLevel(WrapSampler, texcoord, 0);
		wind = fftcolor.x * SharedParamsWindDirection * windSpeed;

		float3 wavesmap_tangent = float3(0, 0, 0);
		//float shift = waveMapShift(posW.xyz, wavesmap_tangent);
		float shift = vortexShift(posW.xyz, wavesmap_tangent);

		float3 wavesmap_normal = float3(wavesmap_tangent.z, 0, -wavesmap_tangent.x);

		wavesmap_normal *= shift;
		wavesmap_normal *= sin(phase0)*0.1;
		wavesmap_tangent *= abs(shift);

		wind += (wavesmap_tangent + wavesmap_normal) * 50;

		// Сила и нормализация
		wind = float3(wind.x, 1, wind.z);
		wind = normalize(wind);

		// wind - нормализван
		float3 shift3 = wind*windFlex;
		//heightScale += sin(phase0)*0.05;
		shift3.xz *= 50.0;

		ANIM_OFFSET += shift3.xz;
	}
#endif

	generateBlade(i[0].pos.xyz, outputStream, o,
		grassSize * float2(widthScale, heightScale * (0.7+0.6*RAND)),
		bladeSegments, RAND2*PI2, RAND, ANIM_OFFSET, heightScale, DIST_GRAD, i[0].color.rgb);
}

#if defined(DEBUG_DRAW_BLADE_ID) || defined(DEBUG_DRAW_LOD_ID)
static const float4 dbgColors[] = 
{
	float4(1,0,0,1),
	float4(0,1,0,1),
	float4(0,0,1,1),
	float4(1,1,0,1),
	float4(0,1,1,1),
	float4(1,0,1,1),
	float4(0,0,0,1),
	float4(1,1,1,1),
};
#endif

#ifdef USE_DCS_DEFERRED
	
#include "deferred/GBuffer.hlsl"

GBuffer BuildGBufferGrass(
	float2 sv_pos_xy, 
	float4 color, float2 normal, float nHeight, float4 projPos)
{
	GBuffer o;
	float3 ec = encodeColorYCC(color.xyz);
	o.target0 = float4(normal.xy, 0, color.a);
	o.target1 = float4(ec.x, nHeight, 0, color.a);
	o.target2 = float4(ec.yz, 0, color.a);
	o.target3 = float4(0, 0, 0, 0);

#if USE_VELOCITY_MAP
	//o.target4 = float4(calcVelocityMapStatic(projPos), 0, color.a);
#endif
	return o;
}

GBuffer ps(in GS_OUTPUT i)
{
#ifdef DEBUG_DRAW_BLADE_ID
	i.color.rgb = dbgColors[i.bladeId%8];
#endif
#ifdef DEBUG_DRAW_LOD_ID
	i.color.rgb = dbgColors[i.lodId];
#endif

	return BuildGBufferGrass(i.pos.xy, float4(i.color.rgb, 1), i.norm.xz, i.norm.y, i.projPos);
}

#else

float4 ps(in GS_OUTPUT i): SV_TARGET0
{
#ifdef DEBUG_DRAW_BLADE_ID
	return dbgColors[i.bladeId%8];
#endif
#ifdef DEBUG_DRAW_LOD_ID
	return dbgColors[i.lodId];
#endif

#ifdef GRASS_SHADING
	// float3 n = mul(i.norm.xyz, (float3x3)gView)*0.5+0.5;
	// return float4(n.zzz, 1);
	float light = dot(i.norm, sunDir.xyz)*0.5+0.5;
	return light;
	// return float4(lerp(AmbientLight(normalize(i.norm)), gSunDiffuse.rgb, light), 1);
	return float4(i.color.rgb * (0.5 + 0.5*light), 1);
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

technique11 grassTech
{
	pass grass
	{
		SetVertexShader(CompileShader(vs_5_0, vs()));
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


//#include "heightmapTest.hlsl"
