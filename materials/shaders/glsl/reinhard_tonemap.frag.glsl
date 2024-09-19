/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"

uniform float exposure = 1.0;

vec4 reinhard_tonemap( vec3 hdr )
{
	// reinhard tone mapping
	vec3 mapped = hdr / ( hdr + vec3( 1.0 ) );

	// gamma correction
	const float gamma = 2.2;
	mapped = pow( mapped, vec3( 1.0 / gamma ) );

	return vec4( mapped, 1.0 );
}
