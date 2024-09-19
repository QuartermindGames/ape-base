/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"
#include "fxaa.inc.glsl"

void main()
{
	pl_frag = applyFXAA( gl_FragCoord.xy, diffuseMap );
}
