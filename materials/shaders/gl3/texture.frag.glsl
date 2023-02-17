/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"

void main() {
    pl_frag = vsShared.colour * texture(diffuseMap, vsShared.uv);
}
