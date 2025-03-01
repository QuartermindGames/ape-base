// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#ifndef _SHARED_INC_GLSL
#define _SHARED_INC_GLSL

const float PI = 3.14159265359;
const float EPSILON = 0.0001;

#if PLG_COMPILE_VERTEX == 1
out
#elif PLG_COMPILE_FRAGMENT == 1
in
#endif
VertexData
{
	vec3 viewPos;
	vec3 position;
	vec3 normal;
	vec2 reflect;
	vec2 uv;
	vec4 colour;
	mat3 tbn;
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

#if PLG_COMPILE_VERTEX == 1

vec3 extract_camera_pos(mat4 modelView)
{
	return vec3(-vec3(modelView[3]) * mat3(modelView));
}

#endif

#endif// _SHARED_INC_GLSL
