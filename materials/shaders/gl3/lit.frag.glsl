// Copyright © 2020-2023 OldTimes Software, Mark E. Sowden <hogsy@oldtimes-software.com>
// Purpose: Base lighting fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

void main()
{
    vec4 diffuse = texture(diffuseMap, vsShared.uv.st);

#ifdef ALPHATEST
    if (diffuse.a < 0.1)
        discard;
#endif

    vec3 n = normalize(texture(normalMap, vsShared.uv.st).rgb * 2.0 - 1.0);
    n = normalize(vsShared.tbn * n);

#ifdef LIGHTING
    vec4 lightTerm = CalculateLighting(n, normalize(vsShared.viewPos - vsShared.position));
#else
    vec4 lightTerm = sun.ambience;
#endif
    vec4 outp = CalculateFogTerm(lightTerm * diffuse);

    pl_frag = outp;
}
