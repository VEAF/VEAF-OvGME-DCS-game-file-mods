float  effectParams;
float3 smokeColor;

#ifdef PUFF_SOFT_PARTICLES
	#define SOFT_PARTICLES		effectParams.x
#endif
#include "ParticleSystem2/common/clusterCommon.hlsl"

// #define DEBUG_OPAQUE
// #define DEBUG_CLUSTER_LIGHT
// #define DEBUG_NO_AMBIENT_LIGHT
// #define DEBUG_NO_NORMALS
// #define DEBUG_OUTPUT_TEMP

// #define CLUSTER_COLOR dbg.xyz
#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_DETAIL_SPEED	0.02
#define CLUSTER_DETAIL_TILE		0.2
#define ANIMATION_SPEED			15
#define CLUSTER_TRANSLUCENCY	0.0
#define PARTICLE_ROTATE_SPEED	0.1
#define CLUSTER_AMBIENT_COLOR	AmbientAverage
#include "ParticleSystem2/common/clusterShading.hlsl"
