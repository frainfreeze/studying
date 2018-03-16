#ifndef CVIJET_H_
#define CVIJET_H_
#include <SFML/Graphics.hpp>
#include <iostream>

///////////////////////////////////////////////////
// Cvijet draws and renders a flower on screen
///////////////////////////////////////////////////
//todo: replace me with fancy 3D model 
class Cvijet {
public:
	Cvijet(sf::RenderWindow* window);

	// todo: position gets broken on resize
	// make flower relative to pedicel
	void setPos(float x, float y);
	void draw();

private:
	sf::RenderWindow * mainWindow;
	sf::Color pedicelColor;

	// sizes
	sf::Vector2f pedicelSize;
	sf::Vector2f flowerSize;

	// positions
	sf::Vector2f flowerPos;
	sf::Vector2f pedicelPos;
	sf::Vector2f leafPos0;
	sf::Vector2f leafPos1;
	sf::Vector2f leafPos2;
	sf::Vector2f leafPos3;
};
#endif // CVIJET_H_