// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "shared.inc.glsl"

uniform vec2 viewportSize = vec2(640.0, 480.0);

uniform float focusPoint;
uniform float focusScale;
uniform float aperture;

float linear_z(float z, float near, float far)
{
	return near / (far + near - z * (far - near));
}

void main()
{
	vec2 pixel = gl_FragCoord.xy / viewportSize;

	float near = 0.1;
	float far = 1000.0;

	vec3 colour = texture(diffuseMap, pixel).rgb;
	float depth = linear_z(texture(depthMap, pixel).r, near, far);

	float coc;
	if (depth < near)
	{
		float x = 0.3;
		coc = -(depth / x - near) * focusScale * max(x, 1.0);
	}
	else
	{
		coc = (depth * far - focusPoint) / focusScale * max(focusPoint, 1.0);
	}

	coc = clamp(coc, 0.0, 1.0);
	if (coc < 0.1)
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
