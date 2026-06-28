// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "shared.inc.glsl"
#include "lighting.inc.glsl"

void main()
{
	gl_ClipDistance[0] = dot(vec4(pl_vposition, 1.0), pl_clipplane);
	gl_Position = (pl_proj * pl_view * pl_model) * vec4(pl_vposition, 1.0);

	vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));

	mat4 modelView = pl_view * pl_model;
	vsShared.viewPos = extract_camera_pos(modelView);
	vsShared.viewAng = extract_camera_ang(modelView);

	vec3 T = normalize(vec3(pl_model * vec4(pl_vtangent, 0.0)));
	vec3 B = normalize(vec3(pl_model * vec4(pl_vbitangent, 0.0)));
	vec3 N = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
	vsShared.tbn = mat3(T, B, N);

	vsShared.normal = N;
	vsShared.colour = pl_vcolour;

	vec4 UV = pl_texture * vec4(pl_vuv[0], 0.0, 1.0);
	vsShared.uv = UV.xy / UV.w;

#ifdef LIGHTMAP
	vsShared.lightmapUV = pl_vuv[1];
#endif

#ifdef PSX_SPYRO
	vsShared.fadeFactor = psx_tex_fade_factor(vsShared.viewPos, vsShared.position, 0.0, 200.0);
#endif

#ifdef LIGHTING
	vec3 v = normalize(vsShared.viewPos - vsShared.position);
	vec3 r = reflect( v, N );
	float m = 2. * sqrt(pow(r.x, 2.) + pow(r.y, 2.) + pow(r.z, 2.));
	vsShared.reflect = r.xy / m + .5;

	io_diffuseLighting = diffuse_lighting( lighting.dir, N );
	io_specularLighting = specular_lighting( v, lighting.dir, N );
	io_rimLighting = rim_lighting( v, lighting.dir, N );
#endif
}
