// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
// Purpose: Gradient sky fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"

const float SAMPLE_HEIGHT = 64;
const float BLUR = 8.0 / SAMPLE_HEIGHT;

const float AMPLITUDE = 0.01;
const float SPEED = 0.01;
const float FREQUENCY = 0.001;

// texture passed is 1x64 gradient, which should span from button to top
// there is no horz handled here, should only deal with vertical for simplicity sake
uniform float viewPitch = 0.0;// degrees (but converted to 0 -> 1, with 1 being 90 and 0 being -90)
uniform vec2 viewSize = vec2(640, 480);

void main()
{
	vec2 uv = (2.0 * gl_FragCoord.xy - viewSize) / viewSize.y / 2.0;
	uv.x = uv.x / viewSize.x * viewSize.x * 0.2;
	uv.y = uv.y / 2.0 + viewPitch;

	float dist = length(uv);
	float height = 0.5 * (1.0 - dist * dist);

	float waveOffset = AMPLITUDE * sin(gl_FragCoord.x * FREQUENCY + float(u_numTicks) * SPEED);

	vec2 nuv = vec2(0.5, clamp(height + 0.5 + waveOffset, 0.0, 1.0));

	vec2 pixelSize = vec2(1.0 / viewSize.x, 1.0 / viewSize.y);

	vec3 skyColour = vec3(0.0);
	for (int i = 0; i < 4; ++i)
	{
		float weight = 0.1 / (i + 1);
		float offset = nuv.y + pixelSize.x * (i * SAMPLE_HEIGHT);
		skyColour += texture(diffuseMap, nuv + vec2(0.5, -0.05 * offset)).rgb * BLUR;
		skyColour += texture(diffuseMap, nuv + vec2(0.5, 0.05 * offset)).rgb * BLUR;
	}

	pl_frag = vec4(skyColour, 1.0);
}
