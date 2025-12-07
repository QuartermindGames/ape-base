/**
 * Copyright © 2020-2024 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>
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

void main()
{
	vec4 dsample = blend_samples_3way( uBlendR, uBlendG, uBlendB, vsShared.uv );
	if ( dsample.a < 0.1 )
	{
		discard;
	}

	vec3 n = normalize( texture( normalMap, vsShared.uv.st ).rgb * 2.0 - 1.0 );
	n = normalize( vsShared.tbn * n );

	vec4 lightTerm = lighting_term( n, normalize( vsShared.viewPos - vsShared.position ) );
	vec4 outp = CalculateFogTerm( lightTerm * dsample );
	pl_frag = outp;
}
