// Copyright © 2020-2024 SnortySoft, Mark E. Sowden <hogsy@snortysoft.net>

#include "../shared.inc.glsl"

uniform float threshold = 0.64;

void main() {
	vec4 colour = texture(diffuseMap, vsShared.uv.st);
	float b = dot(colour.rgb, vec3(0.2126, 0.7152, 0.0722)) * threshold;
	pl_frag = colour * b;
}
