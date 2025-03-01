/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
 */

#include "shared.inc.glsl"
#include "lighting.inc.glsl"

void main()
{
    vec4 diffuse = texture(diffuseMap, vsShared.uv);
    #ifdef ALPHATEST
    if (diffuse.a < 0.1)
    {
        discard;
    }
    #endif

    vec3 n = normalize(texture(normalMap, vsShared.uv).rgb * 2.0 - 1.0);
    n = normalize(vsShared.tbn * n);
    //n = normalize( vsShared.normal );

    vec4 lightTerm = lighting_term(n, normalize(vsShared.viewPos - vsShared.position));

    pl_frag = diffuse * lightTerm;
}
