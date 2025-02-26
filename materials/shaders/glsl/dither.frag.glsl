// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#include "shared.inc.glsl"

// based on the implementation outlined here:
//	http://devlog-martinsh.blogspot.com/2011/03/glsl-8x8-bayer-matrix-dithering.html
// and then further revised based on ompuco's work here:
//	https://gist.github.com/ompuco/3209f1b32213cec5b7bccf0e67caf3e9

// not really accurate but makes the effect more obvious
float scale = 0.5;

float find_closest(int x, int y, float c0)
{
	int dither[4][4] = { { 0, 8, 2, 10 }, { 12, 4, 14, 6 }, { 3, 11, 1, 9 }, { 15, 7, 13, 5 } };
	float limit = c0 * 255.0;
	limit += dither[x % 4][y % 4] / 2.0 - 4.0;
	limit = max(limit, 0.);
	limit = mix(int(limit) & 0xf8, 0xf8, step(0xf8, limit));
	limit /= 255;

	return limit;
}

void main()
{
	vec2 xy = gl_FragCoord.xy * scale;
	int x = int(mod(xy.x, 4));
	int y = int(mod(xy.y, 4));

	vec3 rgb = texture(diffuseMap, vsShared.uv).rgb;
	rgb.r = find_closest(x, y, rgb.r);
	rgb.g = find_closest(x, y, rgb.g);
	rgb.b = find_closest(x, y, rgb.b);

	pl_frag = vec4(rgb, 1.0);
}
