#ifndef _NVD_COMMON_
#define _NVD_COMMON_

#include "common/context.hlsl"
#include "../deferred/DecoderCommon.hlsl"
#include "../deferred/_HMD.hlsl"
#include "../deferred/_helper.hlsl"

#define MASK_SIZE (1.0/0.8)

float getMask(float2 c, float mul) {
	return saturate(mul*(1 - sqrt(dot(c, c))));
}

float2 calcMaskCoord(float2 projPos) {
  if (inVR())
  {
#if NVG_GAIN_ADJUSTS_POSITION
    const float posy = 1 - pow(gain, 0.22);
    const float size = NVG_SIZE - gain;
#else
    const float posy = NVG_VERTICAL_OFFSET;
    const float size = NVG_SIZE;
#endif
    return float2((projPos.x - gProj[2][0]) * gNVDaspect, projPos.y - posy) * size;
  }
  else
  {
    return float2((projPos.x - gNVDpos.x ) * gNVDaspect, projPos.y - gNVDpos.y) * MASK_SIZE;
  }
}

float getNVDMask(float2 projPos) {
	float2 uvm = calcMaskCoord(projPos);
	return getMask(uvm, 10);
}

#endif
