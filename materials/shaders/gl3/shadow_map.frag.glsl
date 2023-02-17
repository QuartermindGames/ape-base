/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"

uniform sampler2D shadowMap;

void main() {
    float depth = 1.0 - (1.0 - texture(shadowMap, vsShared.uv).x) * 25.0;
    pl_frag = vec4(depth);
}
