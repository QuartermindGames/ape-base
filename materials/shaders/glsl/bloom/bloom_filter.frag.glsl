// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "../shared.inc.glsl"

uniform float threshold = 0.0;
uniform float intensity = 0.0;

void main()
{
	vec4 colour = texture( diffuseMap, vsShared.uv );
	float b = dot( colour.rgb, vec3( threshold ) );
	pl_frag = ( ( colour * b ) - dot( colour.rgb, vec3( 0.05 ) ) ) * intensity;
}
