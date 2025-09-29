// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#ifndef _SHARED_INC_GLSL
#define _SHARED_INC_GLSL

const float PI = 3.14159265359;
const float EPSILON = 0.0001;

uniform double u_numTicks = 0.0;
uniform vec2 u_viewSize = vec2(640, 480);

#define PSX_SPYRO

#if PLG_COMPILE_VERTEX == 1
#define INOUT out
#elif PLG_COMPILE_FRAGMENT == 1
#define INOUT in
#endif

#if PLG_COMPILE_VERTEX == 1
out
#elif PLG_COMPILE_FRAGMENT == 1
in
#endif
VertexData
{
	vec3 viewPos;
	vec3 viewAng;

	vec3 position;
	vec3 normal;
	vec2 reflect;
	vec2 uv;
	vec4 colour;
	mat3 tbn;

#ifdef PSX_SPYRO
	float fadeFactor;
#endif
}
vsShared;

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
	vec3 direction;
	float cutOff;
	sampler2D map;
};
uniform Light light;

uniform sampler2D diffuseMap;
uniform sampler2D normalMap;
uniform sampler2D specularMap;
uniform sampler2D sphereMap;
uniform sampler2D depthMap;

#if PLG_COMPILE_VERTEX == 1

vec3 extract_camera_pos(mat4 viewMatrix)
{
	return vec3(-vec3(viewMatrix[3]) * mat3(viewMatrix));
}

vec3 extract_camera_ang(mat4 viewMatrix)
{
	vec3 forward = -normalize(vec3(viewMatrix[0][2], viewMatrix[1][2], viewMatrix[2][2]));
	vec3 up = normalize(vec3(viewMatrix[0][1], viewMatrix[1][1], viewMatrix[2][1]));

	float pitch = asin(-forward.y);
	float yaw = atan(forward.x, -forward.z);

	vec3 right = cross(forward, up);
	vec3 worldUp = vec3(0.0, 1.0, 0.0);
	float roll = atan(dot(right, worldUp), dot(up, worldUp));

	return vec3(pitch, yaw, roll);
}

#endif

/////////////////////////////////////////////////////////////////////////////////////
// PSX-style methods
/////////////////////////////////////////////////////////////////////////////////////

/*
 * This is for emulating a Spyro-style fade when surfaces are far enough.
 */
float PSX_GetDistanceFadeFactor(vec3 viewPos, vec3 worldPos, float fadeStart, float fadeEnd)
{
	float dist = distance(viewPos, worldPos);
	if (dist <= fadeStart) {
		return 0.0;
	} else if (dist >= fadeEnd) {
		return 1.0;
	}

	return smoothstep(fadeStart, fadeEnd, dist);
}

/*
 * This is for emulating a Spyro-style fade when surfaces are far enough.
 */
vec4 PSX_GetDistanceTextureMip(sampler2D tex, vec2 texCoord, float fadeFactor)
{
	int maxMip = textureQueryLevels(tex) - 1;
	if (fadeFactor <= 0.0)
	{
		return texture(tex, texCoord);
	}
	else if (fadeFactor >= 1.0)
	{
		return textureLod(tex, texCoord, float(maxMip));
	}

	vec4 srcColour = texture(tex, texCoord);
	vec4 mipColour = textureLod(tex, texCoord, maxMip);
	return mix(srcColour, mipColour, fadeFactor);
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

#endif// _SHARED_INC_GLSL
