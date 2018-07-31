#ifndef CVIJET_H_
#define CVIJET_H_
#include <iostream>

#include <SFML/Graphics.hpp>

#include "QuadStruct.h"
#include "VertParse.h"
#include "VertQuad.h"

///////////////////////////////////////////////////
// Cvijet draws and renders a flower, background
// and cloak animation on screen
///////////////////////////////////////////////////
class Cvijet {
public:
	Cvijet(sf::RenderWindow* window);

	const void draw(const sf::Time & deltaTime);

	// only moves the flower image
	void setPos(float x, float y);

private:
	sf::RenderWindow * mainWindow;

	// sizes & positions
	sf::Vector2f flowerSize;
	sf::Vector2f flowerPos;

	// containers
	std::vector<QuadStruct> bar;
	VertParser spaz;

	// distortionMap for shader
	sf::Texture distortionMap;

	// background
	sf::Texture texture1;
	sf::Texture texture2;
	
	// anim resources
	sf::Sprite cloak;
	sf::Texture cloak1Tex;
	sf::Texture cloak2Tex;
	sf::Texture cloak3Tex;
	sf::Texture cloak4Tex;
	sf::Texture cloak5Tex;

	// anim
	int numFrames;
	float animDuration;
	
	// initialize clocks for shader and animations
	sf::Clock clock;
	sf::Time elapsedTime;

	// shader
	sf::Shader shader;
	float distortionFactor;
	float riseFactor;
};
#endif // CVIJET_H_