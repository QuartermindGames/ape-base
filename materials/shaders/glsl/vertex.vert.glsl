// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "shared.inc.glsl"

void main()
{
	gl_ClipDistance[0] = dot(vec4(pl_vposition, 1.0), pl_clipplane);
	gl_Position = (pl_proj * pl_view * pl_model) * vec4(pl_vposition, 1.0);

	vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));

	mat4 modelView = pl_view * pl_model;
	vsShared.viewPos = extract_camera_pos(modelView);
	vsShared.viewAng = extract_camera_ang(modelView);

	vsShared.normal = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
	vsShared.tbn = mat3(
		normalize(vec3(pl_model * vec4(pl_vtangent, 0.0))),
		normalize(vec3(pl_model * vec4(pl_vbitangent, 0.0))),
		vsShared.normal);

	vec4 UV = pl_texture * vec4(pl_vuv[0], 0.0, 1.0);
	vsShared.uv = UV.xy / UV.w;

	vsShared.lightmapUV = pl_vuv[1];

	vsShared.colour = pl_vcolour;

	#ifdef PSX_SPYRO
	vsShared.fadeFactor = PSX_GetDistanceFadeFactor(vsShared.viewPos, vsShared.position, 650.0, 700.0);
	#endif
}
