/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"

void main() {
    pl_frag = vsShared.colour * texture(diffuseMap, vsShared.uv);
}
