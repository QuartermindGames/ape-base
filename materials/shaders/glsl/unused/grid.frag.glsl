/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"

void main() {
	vec2 size = vec2(16.0, 16.0);
	vec2 square = size * fract(vsShared.uv * size);
	float thickness = 7.8;
	float smoothness = 0.5;

	vec2 d = abs(square - size * 0.5);
	vec2 grid = smoothstep(thickness - smoothness, thickness + smoothness, d);
	float gridFinal = max(grid.x, grid.y);

	if ( gridFinal == 0 )
	{
		discard;
	}

	pl_frag = vec4(0.5 * gridFinal, 0.0, 0.5 * gridFinal, gridFinal);
}
