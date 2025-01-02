// Copyright © 2020-2025 Quartermind Games, Mark E. Sowden <hogsy@snortysoft.net>

#include "../shared.inc.glsl"
#include "../blur.inc.glsl"

uniform float blurRadius = 32.0;

void main()
{
	vec2 pixelSize = vec2( 2.0 / viewportSize.x, 2.0 / viewportSize.y );
#if 0
	vec4 blur = texture( diffuseMap, vec2( gl_FragCoord ) / viewportSize ) * weights[ 0 ];
	for ( int i = 1; i < NUM_WEIGHTS; ++i )
	{
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( 0.0, offsets[ i ] * 2.0 ) ) / viewportSize ) * weights[ i ];
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( 0.0, offsets[ i ] * 2.0 ) ) / viewportSize ) * weights[ i ];
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( offsets[ i ] * 2.0, 0.0 ) ) / viewportSize ) * weights[ i ];
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( offsets[ i ] * 2.0, 0.0 ) ) / viewportSize ) * weights[ i ];
	}
#else// VERY EXPENSIVE!!!
	vec4 blur = texture( diffuseMap, vec2( gl_FragCoord ) / viewportSize );
	for ( int i = 0; i < 16; ++i )
	{
		float weight = 0.1 / ( i + 1 );
		float offset = pixelSize.x * ( i * ( blurRadius * blurRadius ) );

		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( -offset, offset ) ) / viewportSize ) * weight;
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( offset, -offset ) ) / viewportSize ) * weight;

		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( offset, -offset ) ) / viewportSize ) * weight;
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( -offset, offset ) ) / viewportSize ) * weight;

		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( -offset, -offset ) ) / viewportSize ) * weight;
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( -offset, -offset ) ) / viewportSize ) * weight;

		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) + vec2( offset, offset ) ) / viewportSize ) * weight;
		blur += texture( diffuseMap, ( vec2( gl_FragCoord ) - vec2( offset, offset ) ) / viewportSize ) * weight;
	}
#endif

	pl_frag = blur;
}
