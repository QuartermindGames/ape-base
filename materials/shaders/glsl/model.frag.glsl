// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Model fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"
#include "lighting.inc.glsl"

void main()
{
	vec4 ds = texture( diffuseMap, vsShared.uv ) * vsShared.colour;
#ifdef ALPHATEST
	if ( ds.a < 0.1 )
	{
		discard;
	}
#endif

#ifdef LIGHTING
	ds = ds * vec4( lighting.ambience + io_diffuseLighting, 1.0 );
	ds = ds + vec4( io_rimLighting, 1.0 );
#endif

#ifdef CUBEMAP
	vec3 cr = cubemap_reflect( vsShared.position, vsShared.viewPos, vsShared.normal );
	vec3 cs = texture( cubeMap, cr ).rgb;
	ds = vec4( cs, 1.0 );
#endif

	pl_frag = ds;
}
