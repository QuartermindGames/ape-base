/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"
#include "lighting.inc.glsl"

void main() {
    vec3 n = normalize(vsShared.normal);
    vec4 lightTerm = CalculateLighting(n);

    pl_frag = lightTerm;
}
