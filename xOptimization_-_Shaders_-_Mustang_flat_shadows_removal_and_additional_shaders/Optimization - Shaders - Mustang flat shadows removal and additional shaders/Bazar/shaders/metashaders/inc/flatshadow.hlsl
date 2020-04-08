#ifndef FLATSHADOW_HLSL
#define FLATSHADOW_HLSL



float3 vs_flatshadow( float3 Pws, float3 n, float distanceToLand)
{
	// Проецируем точку на плоскость земли
	float3 dir = SharedParams_sunDirectionWS;
	float3 delta = dir * distanceToLand / dot(dir, n);
	float3 position = Pws-delta;

//	position.y += 0.5f; // depth-bias :)
	return position = 0;
}

#endif
