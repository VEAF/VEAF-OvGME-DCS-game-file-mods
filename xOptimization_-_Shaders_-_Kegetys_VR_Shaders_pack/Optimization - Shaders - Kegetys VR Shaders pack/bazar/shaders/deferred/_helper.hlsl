#ifdef CONTEXT_HLSL
bool inVR()
{
	// detect VR (off-center projection)
	return any(gProj[2][0]);
}

bool _HmdMask(float2 vpos, uint2 bufSize, float maskSize)
{
#if ENABLE_HMD_MASK
	// poor man's invisible area mask for the Vive, similar to the mask from OpenVR SDK (DCS For some reason does not use it)
	if (inVR())
	{
		float2 spos = vpos / (float2) bufSize;
		if (distance(spos, float2(0.5 + gProj[2][0] / 2, 0.5)) > maskSize)
			return true;
	}
#endif
  return false;
}

uint2 getBufferSize(in TEXTURE_2D(uint2, buf))
{
	uint2 bufSize;
#ifdef MSAA	
	uint samples;
	buf.GetDimensions(bufSize.x, bufSize.y, samples);
#else
	buf.GetDimensions(bufSize.x, bufSize.y);
#endif	
	return bufSize;
}
#endif