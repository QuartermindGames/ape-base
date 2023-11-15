// Copyright © 2020-2023 OldTimes Software, Mark E Sowden <hogsy@oldtimes-software.com>

#include "shared.inc.glsl"

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
uniform Light light;

vec4 sterm(vec3 lDir, vec3 viewDir, vec3 specColour, float specPower, vec3 normal)
{
    #ifdef CELL_SHADED

    vec3 r = reflect(-lDir, normal);
    float i = max(dot(viewDir, r), 0.0);
    if (i > 0.75)
    {
        return vec4(specColour, 1.0);
    }

    return vec4(0, 0, 0, 1);

    #else

    vec3 halfway = normalize(lDir + viewDir);
    return vec4(pow(max(dot(normal, halfway), 0.0), specPower) * specColour, 1.0);

    #endif
}

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
    vec3 s = texture(specularMap, vsShared.uv.st).rgb;

    // Apply the sun term first
    vec3 lp = normalize(-sun.position);
    vec4 o;
    o += vec4(sun.colour.rgb, 1.0) * (lterm(n, lp) * sun.colour.a);
    o += sterm(lp, viewDir, s * (sun.colour.rgb * sun.colour.w) * 2.0, 8.0, n);

    lp = normalize(light.position - vsShared.position);
    float d = length(light.position - vsShared.position);
    float r = clamp(1.0 - d * d / (light.radius * light.radius), 0.0, 1.0);
    o += (lterm(n, lp) * (vec4(light.colour.rgb, 1.0) * light.colour.a)) * r;
    o += (sterm(lp, viewDir, s, 16.0, n) * (vec4(light.colour.rgb, 1.0) * light.colour.a)) * r;

    return sun.ambience + o;
}
