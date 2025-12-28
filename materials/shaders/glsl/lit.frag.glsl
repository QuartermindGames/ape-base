// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Base lighting fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

void main()
{
	vec4 diffuse = PSX_GetDistanceTextureMip( diffuseMap, vsShared.uv, vsShared.fadeFactor );
#ifdef ALPHATEST
	if ( diffuse.a < 0.1 )
		discard;
#endif

	vec3 n = normalize( texture( normalMap, vsShared.uv ).rgb * 2.0 - 1.0 );
	n = normalize( vsShared.tbn * n );

#ifdef LIGHTING
	vec4 lightTerm = lighting_term( n, normalize( vsShared.viewPos - vsShared.position ) );
#else
	vec4 lightTerm = sun.ambience;
#endif
	vec4 outp = CalculateFogTerm( lightTerm * diffuse );

    pl_frag = outp;
}
