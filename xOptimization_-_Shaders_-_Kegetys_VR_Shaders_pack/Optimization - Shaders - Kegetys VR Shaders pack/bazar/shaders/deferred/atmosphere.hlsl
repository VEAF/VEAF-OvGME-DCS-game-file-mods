#ifndef DEFERRED_ATMOSPHERE_HLSL
#define DEFERRED_ATMOSPHERE_HLSL

#include "common/AmbientCube.hlsl"

#define FOG_ENABLE
#include "enlight/skyCommon.hlsl"

#include "deferred/deferredCommon.hlsl"
#define FOG_ENABLE
#include "enlight/skyCommon.hlsl"

#if ANALYTIC_TRANSMITTANCE
float rayIntersect(float3 pos, float3 dir, float radius, float outer)
{
	float a = dot(dir, dir);
	float b = 2.0 * dot(pos, dir);
	float c = dot(pos, pos) - radius*radius;
  
	float discr = b * b - 4.0 * a * c;
//	clip(discr); // ray don't intercest sphere

	discr = sqrt(discr);

	float t0 = (-b + discr) / 2.0 * a;
	float t1 = (-b - discr) / 2.0 * a;

	return lerp(t0, t1, step(0, t0*outer));
}

//height in km, return in km
float getAtmosphereThickness(float height, float3 ray)
{
	float r = min(Rg + height, Rt - 0.01);
	// float dr = Rg / r;
	// clip(ray.y + sqrt(1.0 - dr*dr));
	// float Ri = Rg + l*0.001;
	return rayIntersect(float3(0, r, 0), ray, Rt, -1);
}

float3 analyticSunColor(float heightAboveGround, float3 dir)
{
	float3 x = float3(0, Rg + heightAboveGround + heightHack, 0);
	float r = length(x);
    float mu = dot(x, dir) / r;
	// const float lim = -sqrt(1 - (Rg / r) * (Rg / r));
	// mu = min(mu, lim-0.001);
	float thickness = getAtmosphereThickness(heightAboveGround, dir);
	
	return min(analyticTransmittance(r, mu, thickness), 1.0);
}
#else
	float3 analyticSunColor(float altitude, float3 dir)
	{
		AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
		
		float r = atmParams.bottom_radius + altitude + heightHack;
		float muS = dir.y;

		return GetSunRadiance(r, muS) * getFogTransparency(altitude*1000.0, muS, 120000.0) * gOvercastFactor;
	}
#endif

float3 atmApplyLinear(float3 v, float distance, float3 color, float3 normal)
{
	float3 transmittance;
	float3 cameraPos = gEarthCenter + float3(0, heightHack, 0);

#if defined(TRANSMITTANCE_VOLUME_TEXTURE) && !defined(SKY_RADIANCE_TEXTURE)
	float3 inscatterColor = GetSkyRadianceToPoint3D(cameraPos, cameraPos + v*distance, 0.0/*shadow*/, gSunDir, transmittance);
#else
	float3 inscatterColor = GetSkyRadianceToPoint(cameraPos, cameraPos + v*distance, 0.0/*shadow*/, gSunDir, transmittance);
#endif

	return color*transmittance + inscatterColor*gAtmIntensity;
	// return frac(transmittance*100)*gAtmIntensity;
	// return transmittance*gAtmIntensity;
	// return inscatterColor*gAtmIntensity;
}

float3 applyAtmosphereLinearInternal(float3 camera, float3 pos, float3 color, float3 normal, float3 skyColor)
{
	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);
	float3 view = cpos/d;
	float skyLerpFactor = smoothstep(atmNearDistance, atmFarDistance, d);

	// dont do atmosphere for things near the camera
	const float nlimit = 0.5;
	if (d > nlimit)
	{
		color = atmApplyLinear(view, d - nlimit, color, normal);
	}
  color = applyFog(color, view, d * 1000.0);
	
	return lerp(color, skyColor, skyLerpFactor);
}

float3 applyAtmosphereLinear(float3 camera, float3 pos, float4 projPos, float3 color, float3 normal=float3(0,1,0)) {

#ifdef NO_ATMOSPHERE
	return color;
#endif

	float2 tc = float2(0.5f *projPos.x/projPos.w + 0.5, -0.5f * projPos.y/projPos.w + 0.5);	
	float3 skyColor = skyTex.SampleLevel(gBilinearClampSampler, tc.xy, 0).rgb;

	return applyAtmosphereLinearInternal(camera, pos, color, normal, skyColor);
}

float3 applyAtmosphereLinear(float3 camera, float3 pos, float4 projPos, float3 color, float3 normal, float3 skyColor)
{
#ifdef NO_ATMOSPHERE
	return color;
#endif
	return applyAtmosphereLinearInternal(camera, pos, color, normal, skyColor);
}

float3 sampleSkyCS(float2 c) {
	uint2 c1 = floor(c);
	uint2 c2 = ceil(c);
	return lerp(lerp(skyTex.Load(uint3(c1, 0)).rgb, skyTex.Load(uint3(c2.x, c1.y, 0)).rgb, frac(c.x)),
			    lerp(skyTex.Load(uint3(c1.x, c2.y, 0)).rgb, skyTex.Load(uint3(c2, 0)).rgb, frac(c.x)), frac(c.y));
}

#endif
