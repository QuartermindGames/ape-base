// Copyright © 2020-2023 OldTimes Software, Mark E Sowden <hogsy@oldtimes-software.com>

#include "shared.inc.glsl"

uniform float extrude = 0.45;
uniform vec3 lightPosition;

void main()
{
    vsShared.colour = vec4(1.0, 1.0, 1.0, 1.0);

    gl_Position = pl_proj * pl_view * pl_model * vec4(pl_vposition, 1.0);
}
