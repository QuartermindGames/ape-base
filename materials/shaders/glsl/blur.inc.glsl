/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

#define NUM_WEIGHTS 5

uniform vec2 viewportSize;

// Technically , this isn ’t quite a ’ gaussian ’ distribution ...
const float weights[ NUM_WEIGHTS ] = float[]( 0.12, 0.22, 0.32, 0.22, 0.12 );
