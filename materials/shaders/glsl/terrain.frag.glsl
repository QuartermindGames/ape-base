// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
// Purpose: Terrain fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

void main()
{
	vec2 uv = ( vsShared.position.xz ) / 128.0;
	vec4 diffuse = PSX_GetDistanceTextureMip( diffuseMap, uv, vsShared.fadeFactor );
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
