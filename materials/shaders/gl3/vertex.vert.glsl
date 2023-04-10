/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"

void main() {
	gl_Position = pl_proj * pl_view * pl_model * vec4(pl_vposition, 1.0);

	vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));
	vsShared.view = normalize(-vsShared.position);

	vec3 T = normalize(vec3(pl_model * vec4(pl_vtangent, 0.0)));
	vec3 B = normalize(vec3(pl_model * vec4(pl_vbitangent, 0.0)));
	vec3 N = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
	vsShared.tbn = mat3(T, B, N);

	vsShared.uv = pl_vuv;
	vsShared.colour = pl_vcolour;
	vsShared.normal = N;
}
