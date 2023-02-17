/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"

void main() {
    vec4 samp = texture(diffuseMap, vsShared.uv);
    if (samp.a < 0.1) {
        discard;
    }

    pl_frag = vsShared.colour * samp;
}