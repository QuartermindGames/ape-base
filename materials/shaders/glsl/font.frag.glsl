// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Fragment shader for single-channel textures

#include "shared.inc.glsl"

void main()
{
	pl_frag = vec4( vsShared.colour.r,
	                vsShared.colour.g,
	                vsShared.colour.b,
	                texture( diffuseMap, vsShared.uv ).r * vsShared.colour.a );
}
