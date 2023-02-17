/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"
#include "materials/shaders/gl3/fxaa.inc.glsl"

void main() {
    pl_frag = applyFXAA(gl_FragCoord.xy, diffuseMap);
}
