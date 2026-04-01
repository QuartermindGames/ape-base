// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Fog effects
// Author:  Mark E. Sowden

#include "shared.inc.glsl"

uniform float fogFar = 11.0;
uniform float fogNear = 32.0;
uniform vec4 fogColour = vec4(0.50, 0.83, 1.0, 0.1);

vec4 fog_apply(vec4 n, vec3 viewPos, vec3 worldPos)
{
    float fogDistance = distance(viewPos, worldPos);
    float fogAmount = 1.0 - clamp((fogDistance - fogFar) / (fogNear - fogFar), 0.0, 1.0);
    return mix(n, fogColour, fogAmount);
}
