// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#ifndef _SHARED_INC_GLSL
#define _SHARED_INC_GLSL

/////////////////////////////////////////////////////////////////////////////////////
// Below is a summary of the available pre-processor flags, and what they can do.
// You'll want to set these via your shader definition file, under the 'definitions'
// block.
//
// LIGHTING	Dynamic per-pixel lighting.
// LIGHTMAP	Baked lighting.
// CLOUD	Enables/disables cloud coverage.
// WATER	Depends on the above, but will fade it based on height.
/////////////////////////////////////////////////////////////////////////////////////

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
	vec2 lightmapUV;

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

// this seems terrible, maybe we could
// just treat these as generic slots of some kind?
uniform sampler2D diffuseMap;
uniform sampler2D normalMap;
uniform sampler2D specularMap;
uniform sampler2D sphereMap;
uniform sampler2D depthMap;
uniform sampler2D detailMap;
uniform sampler2D lightMap;

/////////////////////////////////////////////////////////////////////////////////////
// Terrain
/////////////////////////////////////////////////////////////////////////////////////

struct Terrain
{
	sampler2D	height;
	vec2		resolution;
	float		scale;
};
uniform Terrain terrain;

float terrain_get_height( vec2 uv )
{
	return texture( terrain.height, uv ).r;
}

vec3 terrain_get_normal( vec2 uv, float str )
{
	vec2 step = 1.0 / terrain.resolution;

	float hl = terrain_get_height( uv + vec2(-step.x, 0.0) );
	float hr = terrain_get_height( uv + vec2(step.x, 0.0) );
	float hd = terrain_get_height( uv + vec2(0.0, -step.y) );
	float hu = terrain_get_height( uv + vec2(0.0, step.y) );

	float dx = hl - hr;
	float dy = hd - hu;

	vec3 normal = vec3( dx, dy, 1.0 / str );
	return normalize( normal );
}

/////////////////////////////////////////////////////////////////////////////////////
// Bicubic Filtering
// https://web.archive.org/web/20180927181721/http://www.java-gaming.org/index.php?topic=35123.0
/////////////////////////////////////////////////////////////////////////////////////

vec4 cubic(float v)
{
	vec4 n = vec4(1.0, 2.0, 3.0, 4.0) - v;
	vec4 s = n * n * n;
	float x = s.x;
	float y = s.y - 4.0 * s.x;
	float z = s.z - 4.0 * s.y + 6.0 * s.x;
	float w = 6.0 - x - y - z;
	return vec4(x, y, z, w) * (1.0/6.0);
}

vec4 textureBicubic(sampler2D sampler, vec2 texCoords)
{
	vec2 texSize = vec2(textureSize(sampler, 0));
	vec2 invTexSize = 1.0 / texSize;

	texCoords = texCoords * texSize - 0.5;


	vec2 fxy = fract(texCoords);
	texCoords -= fxy;

	vec4 xcubic = cubic(fxy.x);
	vec4 ycubic = cubic(fxy.y);

	vec4 c = texCoords.xxyy + vec2(-0.5, +1.5).xyxy;

	vec4 s = vec4(xcubic.xz + xcubic.yw, ycubic.xz + ycubic.yw);
	vec4 offset = c + vec4(xcubic.yw, ycubic.yw) / s;

	offset *= invTexSize.xxyy;

	vec4 sample0 = texture(sampler, offset.xz);
	vec4 sample1 = texture(sampler, offset.yz);
	vec4 sample2 = texture(sampler, offset.xw);
	vec4 sample3 = texture(sampler, offset.yw);

	float sx = s.x / (s.x + s.y);
	float sy = s.z / (s.z + s.w);

	return mix(
	mix(sample3, sample2, sx), mix(sample1, sample0, sx)
	, sy);
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

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

vec4 blend_samples_3way(sampler2D t0, sampler2D t1, sampler2D t2, vec2 uv)
{
	vec4 sampleA = texture(t0, uv);
	vec4 sampleB = texture(t1, uv);
	vec4 sampleC = texture(t2, uv);
	return sampleA * (1 - vsShared.colour.g) + sampleB * vsShared.colour.g;
}

/////////////////////////////////////////////////////////////////////////////////////
// PSX-style methods
/////////////////////////////////////////////////////////////////////////////////////

/*
 * This is for emulating a Spyro-style fade when surfaces are far enough.
 */
float PSX_GetDistanceFadeFactor(vec3 viewPos, vec3 worldPos, float fadeStart, float fadeEnd)
{
	float dist = distance(viewPos, worldPos);
	if (dist <= fadeStart)
	{
		return 0.0;
	}
	else if (dist >= fadeEnd)
	{
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
