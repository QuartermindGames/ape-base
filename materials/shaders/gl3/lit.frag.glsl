/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

void main() {
	vec4 diffuse = texture(diffuseMap, vsShared.uv.st);

#ifdef ALPHATEST
	if (diffuse.a < 0.1)
	{
		discard;
	}
#endif

	vec3 n = normalize(texture(normalMap, vsShared.uv.st).rgb * 2.0 - 1.0);
	n = normalize(vsShared.tbn * n);

	vec4 lightTerm = CalculateLighting(n, normalize(vsShared.viewPos - vsShared.position));
	vec4 outp = CalculateFogTerm(lightTerm * diffuse);
	pl_frag = outp;
}
