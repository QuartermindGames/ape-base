// Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#include "shared.inc.glsl"

//#define SUN
#define SPECULAR

#ifdef SPECULAR
float sterm(vec3 lDir, vec3 viewDir, float specular, float specPower, vec3 normal)
{
	#ifdef CELL_SHADED

	vec3 r = reflect(-lDir, normal);
	float i = max(dot(viewDir, r), 0.0);
	if (i > 0.75)
	{
		return specular;
	}

	return 0.0f;

	#else

	vec3 halfway = normalize(lDir + viewDir);
	return pow(max(dot(normal, halfway), 0.0), specPower) * specular;

	#endif
}
#endif

float lterm(vec3 n, vec3 l)
{
	#ifdef CELL_SHADED

	float i = dot(n, l);

	float o = 0.0;
	if (i > 0.75) { o += (i / 2); }
	if (i > 0.50) { o += (i / 2); }
	if (i > 0.25) { o += (i / 2); }

	return o;

	#else

	return max(dot(n, l), 0.0);

	#endif
}

vec4 CalculateLighting(vec3 n, vec3 viewDir)
{
	#ifdef SPECULAR
	float specular = texture(specularMap, vsShared.uv.st).r;
	#endif

	vec3 lp;
	vec4 o;

	#ifdef SUN
	// Apply the sun term first
	lp = normalize(-sun.position);
	o += vec4(sun.colour.rgb, 1.0) * (lterm(n, lp) * sun.colour.a);
	#ifdef SPECULAR
	o += sterm(lp, viewDir, specular * (sun.colour.rgb * sun.colour.w) * 2.0, 8.0, n);
	#endif
	#endif

	// "normal" light point term
	lp = normalize(light.position - vsShared.position);
	float d = length(light.position - vsShared.position);
	float r = clamp(1.0 - d * d / (light.radius * light.radius), 0.0, 1.0);
	o += (lterm(n, lp) * (vec4(light.colour.rgb, 1.0) * light.colour.a)) * r;
	#ifdef SPECULAR
	o += (sterm(lp, viewDir, specular, 16.0, n) * (vec4(light.colour.rgb, 1.0) * light.colour.a)) * r;
	#endif

	return sun.ambience + o;
}
