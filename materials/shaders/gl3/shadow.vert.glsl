// Copyright © 2020-2023 OldTimes Software, Mark E Sowden <hogsy@oldtimes-software.com>

#include "shared.inc.glsl"

uniform float extrude = 0.45;
uniform vec3 lightPosition;

void main()
{
    mat4 MVP = pl_proj * pl_view * pl_model;

    vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));
    vsShared.normal = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
    vsShared.colour = pl_vcolour;

    gl_Position = MVP * vec4(pl_vposition, 1.0);
}
