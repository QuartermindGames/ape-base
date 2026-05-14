// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Skybox fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"

void main()
{
	vec3 viewDir = normalize(vsShared.position - vsShared.viewPos);
	// in our setup, y is up/down so we need to swap
	pl_frag = texture(cubeMap, vec3(viewDir.x, viewDir.z, viewDir.y));
}
