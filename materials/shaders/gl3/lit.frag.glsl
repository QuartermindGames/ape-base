/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"
#include "materials/shaders/gl3/lighting.inc.glsl"
#include "materials/shaders/gl3/fog.inc.glsl"

#define ALPHATEST

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

	vec4 lightTerm = CalculateLighting(n);
	vec4 outp = CalculateFogTerm(lightTerm * diffuse);
	pl_frag = outp;
}
