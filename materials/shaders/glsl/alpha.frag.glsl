/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"

void main()
{
	vec4 samp = texture( diffuseMap, vsShared.uv );
	if ( samp.a < 0.1 )
	{
		discard;
	}

	pl_frag = vsShared.colour * samp;
}