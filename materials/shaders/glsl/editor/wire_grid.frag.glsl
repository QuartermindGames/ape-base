// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "../shared.inc.glsl"

uniform vec3 cursorPos;
uniform int gridScale;

void main() {
	float dist = distance(cursorPos, vsShared.position);
	float fade = 1.0 - smoothstep(0.5, 1.0, dist / (gridScale * 8));

	pl_frag = vec4(vsShared.colour.r, vsShared.colour.g, vsShared.colour.b, fade);
}
