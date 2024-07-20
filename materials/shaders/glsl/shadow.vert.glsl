// Copyright © 2020-2024 SnortySoft, Mark E. Sowden <hogsy@snortysoft.net>

#include "shared.inc.glsl"

// if enabled, do extrusion in vertex shader
//#define OPT_EXTRUDE

void main()
{
    vsShared.position = vec3(pl_model * vec4(pl_vposition, 1.0));
    vsShared.normal = normalize(vec3(pl_model * vec4(pl_vnormal, 0.0)));
    vsShared.colour = pl_vcolour;

    #ifdef OPT_EXTRUDE

    vec3 dir = normalize(vsShared.position - light.position);
    float d = dot(vsShared.normal, dir);

    float extrude;
    if (d > 0)
    {
        vsShared.colour = vec4(1);
        extrude = 10000.0;
    }
    else
    {
        vsShared.colour = vec4(1);
        extrude = 0.0;
    }

    vec3 newPos = pl_vposition + (dir * extrude);
    gl_Position = pl_proj * pl_view * pl_model * vec4(newPos, 1.0);

    #else

    gl_Position = (pl_proj * pl_view * pl_model) * vec4(pl_vposition, 1.0);

    #endif
}
