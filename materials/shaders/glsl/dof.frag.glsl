// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "shared.inc.glsl"

uniform vec2 viewportSize = vec2(640.0, 480.0);

uniform float focusPoint;
uniform float focusScale;
uniform float aperture;

float linear_z(float z, float near, float far)
{
	return (2.0 * near) / (far + near - z * (far - near));
}

void main()
{
	vec2 pixel = gl_FragCoord.xy / viewportSize;

	vec3 colour = texture(diffuseMap, pixel).rgb;
	float depth = linear_z(texture(depthMap, pixel).r, 0.1, 10000.0);

	float objectDistance = 0.5;

	float coc = (depth * 1000.0 - focusPoint) / focusScale * max(focusPoint, 1.0);
	coc = clamp(coc, 0.0, 1.0);
	if (coc < 0.01)
	{
		pl_frag = vec4(colour, 1.0);
		return;
	}

	vec3 blurred = vec3(0.0);
	float totalWeight = 0.0;

	int kernelSize = int(coc * aperture) + 1;
	for (int x = -kernelSize; x <= kernelSize; ++x)
	{
		for (int y = -kernelSize; y <= kernelSize; ++y)
		{
			vec2 offset = vec2(x, y)/textureSize(diffuseMap, 0);
			float weight = (length(vec2(x, y)) / float(kernelSize));
			if (weight > 0.0)
			{
				blurred += texture(diffuseMap, pixel + offset * coc * aperture).rgb * weight;
				totalWeight += weight;
			}
		}
	}

	blurred /= totalWeight;

	pl_frag = vec4(mix(colour, blurred, coc), 1.0);
}
