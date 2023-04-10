/**
 * Copyright (C) 2020-2021 Mark E Sowden <hogsy@oldtimes-software.com>
 */

uniform sampler2D uBlendR;
uniform sampler2D uBlendRNormal;
uniform sampler2D uBlendG;
uniform sampler2D uBlendGNormal;
uniform sampler2D uBlendB;
uniform sampler2D uBlendBNormal;

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

vec4 BlendTextures(sampler2D t0, sampler2D t1, sampler2D t2) {
    vec4 sampleA = texture2D(t0, vsShared.uv.st);
    vec4 sampleB = texture2D(t1, vsShared.uv.st);
	vec4 sampleC = texture2D(t2, vsShared.uv.st);
    return sampleA * (1 - vsShared.colour.g) + sampleB * vsShared.colour.g;
}

void main() {
    vec4 dsample = BlendTextures(uBlendR, uBlendG, uBlendB);
    if (dsample.a < 0.1) {
        discard;
    }

    vec3 n = normalize(texture2D(normalMap, vsShared.uv.st).rgb * 2.0 - 1.0);
    n = normalize(vsShared.tbn * n);

    vec4 lightTerm = CalculateLighting(n);
    vec4 outp = CalculateFogTerm( lightTerm * dsample );
    pl_frag = outp;
}
