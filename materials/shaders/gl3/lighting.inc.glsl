/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

struct Material
{
	float specularPower;
};
uniform Material material;

struct Sun
{
	vec4 colour;
	vec3 position;
	vec4 ambience;
};
uniform Sun sun;

struct Light
{
	vec4 colour;
	float radius;
	vec3 position;
};
uniform Light lights[8];
uniform uint numLights = 0U;

//#define CELL_SHADED

vec4 sterm(vec3 lDir, vec3 viewDir, vec3 specColour, float specPower, vec3 normal)
{
	#ifdef CELL_SHADED
	vec3 r = reflect(-lDir, normal);
	float i = max(dot(r, viewDir), 0.0);
	if (i > 0.75)
	{
		return vec4(specColour, 1.0);
	}

	return vec4(0, 0, 0, 1);
	#else
	vec3 r = reflect(-lDir, normal);
	return vec4(pow(max(dot(r, viewDir), 0.0), specPower) * specColour, 1.0);
	#endif
}

float lterm(vec3 n, vec3 l)
{
	#ifdef CELL_SHADED
	float i = dot(n, l);
	if (i > 0.0)
	{
		return i;
	}

	return 0.0;
	#else
	return max(dot(n, l), 0.0);
	#endif
}

vec4 CalculateLighting(vec3 n)
{
	vec3 s = texture(specularMap, vsShared.uv.st).rgb;

	// Apply the sun term first
	vec3 lp = normalize(-sun.position);
	vec4 o;
	o += vec4(sun.colour.rgb, 1.0) * (lterm(n, lp) * sun.colour.a);
	o += sterm(lp, vsShared.view, s * (sun.colour.rgb * sun.colour.w) * 2.0, 8.0, n);

	// Now iterate over each of the light sources we have
	for (uint i = 0U; i < numLights; ++i)
	{
		lp = normalize(lights[i].position - vsShared.position);
		float d = length(lights[i].position - vsShared.position);
		float r = clamp(1.0 - d*d/(lights[i].radius*lights[i].radius), 0.0, 1.0);

		o += ((lterm(n, lp) + sterm(lp, vsShared.view, s, 16.0, n)) * (vec4(lights[i].colour.rgb, 1.0) * lights[i].colour.a)) * r;

		//o += (lterm(n, lp) * (vec4(lights[i].colour.rgb, 1.0) * lights[i].colour.a)) / a;//(lights[i].radius - distance);
		//o += sterm(lp, vsShared.view, s * lights[i].colour.a * (lights[i].radius - distance), 8.0, n);
	}

	return sun.ambience + o;
}
