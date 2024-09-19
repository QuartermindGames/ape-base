/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"

uniform float uThickness = 0.15;

void main()
{
	vsShared.colour = vec4( 0.0, 0.0, 0.0, 1.0 );

	vec3 newPos = pl_vposition + ( pl_vnormal * uThickness );
	gl_Position = pl_proj * pl_view * pl_model * vec4( newPos, 1.0 );
}
