shader_type canvas_item;

/*This shader basically attempts to replicate the skewing/rotation that's used in the planes
in SEGA Genesis/Megadrive games such as Sonic the Hedgehog 3 & Knuckles, Puggsy,
Contra: Hard Corps, Batman & Robin, etc.

Recommended for textures' width to be a multiple of 16, since the vertical scrolling
on the Genesis can only move 2 8x8 tiles at the same time.

Used this video as reference, courtesy of Jon Burton of Traveller's Tales: https://www.youtube.com/watch?v=Q5iqSzKYZoQ
*/

//SKEW PARAMETERS

/**
*Offset for the horizontal side of skewing.
*/
uniform float skewOffX : hint_range(-1.0, 1.0, 0.1) = 0.0;



/**
*The amount of lines each strip can hold horizontally.
*/
uniform int skewStripsX : hint_range(1, 256.0, 1) = 1;

/**
*Offset for the vertical side of skewing.
*/
uniform float skewOffY : hint_range(-1.0, 1.0, 0.1) = 0.0;

/**
*The offset in which the skewing should be centered at.
*/
uniform vec2 skewOrigin = vec2(0.0, 0.0);

//SINEWAVE PARAMETERS

/**
* The offset for the horizontal wave. 
*/ 
uniform float waveOffX = 0.0;


/**
* The amplitude for the horizontal wave (how long it should travel).
*/ 
uniform float waveAmpX = 0.0;

/**
* The frequency for the horizontal wave (how many waves there should be).
*/ 
uniform float waveFreqX = 1.0;

/**
* The offset for the vertical wave. 
*/ 
uniform float waveOffY = 0.0;

/**
* The amplitude for the vertical wave (how long it should travel).
*/ 
uniform float waveAmpY = 0.0;


/**
* The frequency for the vertical wave (how many waves there should be).
*/ 
uniform float waveFreqY = 1.0;



void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uvBase = UV;
	ivec2 tSize = textureSize(TEXTURE, 0);
	
	//TEXTURE X SINEWAVE
	float sineX = sin(waveOffX + (uvBase.y * waveFreqX)) * (waveAmpX / float(tSize.x));
	uvBase.x += sineX;
	
	//TEXTURE SKEWING
	uvBase.x += (skewOffX * (floor((uvBase.y - (skewOrigin.y / float(tSize.y))) * float(tSize.y / skewStripsX)) / (float(tSize.y / skewStripsX))));
	uvBase.y += (skewOffY * (floor((uvBase.x - (skewOrigin.x / float(tSize.x))) * (float(tSize.x / 16))) / (float(tSize.x / 16))));
	
	//TEXTURE Y SINEWAVE
	float sineY = sin((waveOffY + (((floor((uvBase.x * float(tSize.x / 16))) / float(tSize.x / 16)) + (floor(((float(tSize.x / 16)))) / 16.0))) * (waveFreqY))) * (waveAmpY / float(tSize.y));
	uvBase.y += sineY;
	
	
	//Apply the final UV positions to the texture.
	vec4 finalTex = texture(TEXTURE, uvBase);
	COLOR = finalTex;
	
}
