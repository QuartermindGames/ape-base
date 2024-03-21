/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"
#include "fxaa.inc.glsl"

void main()
{
	pl_frag = applyFXAA( gl_FragCoord.xy, diffuseMap );
}
