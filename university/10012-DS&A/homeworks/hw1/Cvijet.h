#ifndef CVIJET_H_
#define CVIJET_H_
#include <SFML/Graphics.hpp>
#include <iostream>

#include "QuadStruct.h"
#include "VertParse.h"
#include "VertQuad.h"


///////////////////////////////////////////////////
// Cvijet draws and renders a flower on screen
///////////////////////////////////////////////////
//todo: replace me with fancy 3D model perhaps?
class Cvijet {
public:
	Cvijet(sf::RenderWindow* window);

	// todo: position gets broken on resize
	// make flower relative to pedicel
	void setPos(float x, float y);

	void draw();

private:
	sf::RenderWindow * mainWindow;

	// sizes
	sf::Vector2f flowerSize;
	// positions
	sf::Vector2f flowerPos;

	// containers
	QuadContainer bar;
	VertParser spaz;
};
#endif // CVIJET_H_