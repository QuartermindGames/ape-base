// Copyright © 2020-2026 Quartermind Games, Mark E. Sowden <markelswo@gmail.com>

#include "../shared.inc.glsl"
#include "../blur.inc.glsl"

uniform float blurRadius = 32.0;

void main()
{
	vec2 pixelSize = vec2( 2.0 / viewportSize.x, 2.0 / viewportSize.y );

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

	pl_frag = blur;
}
