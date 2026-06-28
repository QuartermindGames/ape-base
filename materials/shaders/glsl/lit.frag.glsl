// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>
// Purpose: Base lighting fragment shader.
// Author:  Mark E. Sowden

#include "shared.inc.glsl"
#include "lighting.inc.glsl"
#include "fog.inc.glsl"

#define DETAIL
#define FOG

void main()
{
	vec4 diffuse = texture( diffuseMap, vsShared.uv ); //psx_tex_fade_mip( diffuseMap, vsShared.uv, vsShared.fadeFactor );
#ifdef ALPHATEST
	if ( diffuse.a < 0.1 )
	{
		discard;
	}
#endif

	// diffuse
	vec4 o = diffuse;// * vsShared.colour;

#ifdef LIGHTMAP
	o.rgb = textureBicubic( lightMap, vsShared.lightmapUV ).rgb * o.rgb;
#endif

#ifdef DETAIL
	vec3 detail = psx_tex_fade_zero( detailMap, vsShared.uv * 2.0, vsShared.fadeFactor );
	o.rgb = 2.0 * ( o.rgb * detail );
#endif

#ifdef FOG
	o = fog_apply( o, vsShared.viewPos, vsShared.position );
#endif

	pl_frag = o;

/*#else

	vec3 n = normalize( texture( normalMap, vsShared.uv ).rgb * 2.0 - 1.0 );
	n = normalize( vsShared.tbn * n );

	#ifdef LIGHTING
	vec4 lightTerm = lighting_term( n, normalize( vsShared.viewPos - vsShared.position ) );
	#else
	vec4 lightTerm = vec4( 0.0 );
	#endif
	vec4 outp = fog_apply( lightTerm * diffuse, vsShared.viewPos, vsShared.position  );

	pl_frag = outp;

#endif*/
}
