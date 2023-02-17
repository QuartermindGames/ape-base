/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"
#include "materials/shaders/gl3/lighting.inc.glsl"

void main() {
    vec3 n = normalize(vsShared.normal);
    vec4 lightTerm = CalculateLighting(n);

    pl_frag = lightTerm;
}
