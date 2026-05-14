// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Skybox vertex shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"

void main()
{
	mat4 modelViewProj = pl_proj * pl_view * pl_model;
	gl_Position = modelViewProj * vec4(pl_vposition, 1.0);

	vsShared.viewPos = extract_camera_pos(pl_view);
	vsShared.position = vec3(pl_model *vec4(pl_vposition, 1.0));
}
