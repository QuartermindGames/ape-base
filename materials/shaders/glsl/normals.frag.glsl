/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"

void main()
{
	pl_frag = vec4( normalize( vsShared.normal ), 1.0 );
}
