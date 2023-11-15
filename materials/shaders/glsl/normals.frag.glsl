/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "shared.inc.glsl"

void main() {
    pl_frag = vec4(normalize(vsShared.normal), 1.0);
}
