// SPDX-License-Identifier: LGPL-3.0-or-later
// Copyright © 2020-2024 SnortySoft, Mark E. Sowden <hogsy@snortysoft.net>
// Purpose: Fragment shader for single-channel textures

#include "shared.inc.glsl"

void main()
{
	pl_frag = vec4( vsShared.colour.r,
	                vsShared.colour.g,
	                vsShared.colour.b,
	                texture( diffuseMap, vsShared.uv ).r );
}
