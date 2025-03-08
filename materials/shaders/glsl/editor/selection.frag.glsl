/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

void main() {
	vec2 square = fract(gl_FragCoord.xy / vec2(2.0, 2.0));
	float gridFinal = step(square.x * square.y, 0.1);
	if (gridFinal == 0) {
		discard;
	}

	pl_frag = vec4(0.0, 0.0, 0.45 * gridFinal, 1.0);
}
