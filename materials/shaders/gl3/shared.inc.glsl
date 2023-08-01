// Copyright © 2020-2023 OldTimes Software, Mark E Sowden <hogsy@oldtimes-software.com>

#ifndef _SHARED_INC_GLSL
#define _SHARED_INC_GLSL

const float PI = 3.14159265359;
const float EPSILON = 0.0001;

#define MAX_LIGHTS 8

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
vec2 uv;
vec4 colour;
mat3 tbn;
} vsShared;

uniform vec2 uTextureScale;
uniform vec2 uTextureOffset;

uniform sampler2D diffuseMap;
uniform sampler2D normalMap;
uniform sampler2D specularMap;

#endif // _SHARED_INC_GLSL
