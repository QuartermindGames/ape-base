/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"
#include "lighting.inc.glsl"

void main()
{
	vec3 n = normalize( vsShared.normal );
	vec4 lightTerm = CalculateLighting( n, normalize( vsShared.viewPos - vsShared.position ) );

	pl_frag = lightTerm;
}
