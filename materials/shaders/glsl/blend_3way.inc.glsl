// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: 3 way vertex texture blend.
// Author:  Mark E. Sowden

uniform sampler2D u_blendR;
uniform sampler2D u_blendG;
uniform sampler2D u_blendB;

vec4 blend_samples_3way(sampler2D t0, sampler2D t1, sampler2D t2, vec2 uv)
{
    vec3 x = texture(t0, uv).rgb * vsShared.colour.r;
    vec3 y = texture(t1, uv).rgb * vsShared.colour.g;
    vec3 z = texture(t2, uv).rgb * vsShared.colour.b;

    vec3 result;
    result.x = (x.x + y.x + z.x) / 3.0;
    result.y = (x.y + y.y + z.y) / 3.0;
    result.z = (x.z + y.z + z.z) / 3.0;

    return vec4(result, 1.0);
}
