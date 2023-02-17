/* Copyright © 2020-2022 Mark E Sowden <hogsy@oldtimes-software.com> */

#include "materials/shaders/gl3/shared.inc.glsl"

uniform float threshold = 0.64;

void main() {
	vec4 colour = texture(diffuseMap, vsShared.uv.st);
	float b = dot(colour.rgb, vec3(0.2126, 0.7152, 0.0722)) * threshold;
	pl_frag = colour * b;
}
