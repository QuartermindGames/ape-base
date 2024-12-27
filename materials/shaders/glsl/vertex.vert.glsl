// Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#include "shared.inc.glsl"

void main()
{
	gl_ClipDistance[0] = dot(vec4(pl_vposition, 1.0), pl_clipplane);
	gl_Position = (pl_proj * pl_view * pl_model) * vec4(pl_vposition, 1.0);

	vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));
	vsShared.viewPos = extract_camera_pos(pl_view * pl_model);

	vec3 T = normalize(vec3(pl_model * vec4(pl_vtangent, 0.0)));
	vec3 B = normalize(vec3(pl_model * vec4(pl_vbitangent, 0.0)));
	vec3 N = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
	vsShared.tbn = mat3(T, B, N);

	vec4 UV = pl_texture * vec4(pl_vuv, 0.0, 1.0);
	vsShared.uv = UV.xy / UV.w;
	vsShared.colour = pl_vcolour;
	vsShared.normal = N;
}
