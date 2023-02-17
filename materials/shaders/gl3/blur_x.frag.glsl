/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#include "materials/shaders/gl3/shared.inc.glsl"
#include "materials/shaders/gl3/blur.inc.glsl"

void main() {
    vec2 pixelSize = vec2( 2.0 / viewportSize.x, 2.0 / viewportSize.y );
    vec2 values[NUM_WEIGHTS] = vec2[](
    vec2(-pixelSize.x * 2, 0.0),
    vec2(-pixelSize.x * 1, 0.0),
    vec2(0, 0.0),
    vec2(pixelSize.x * 1, 0.0),
    vec2(pixelSize.x * 2, 0.0)
    );
    for (int i = 0; i < NUM_WEIGHTS; ++i) {
        vec4 tmp = texture(diffuseMap, vsShared.uv + values[i]);
        pl_frag += tmp * weights[i];
    }
}
