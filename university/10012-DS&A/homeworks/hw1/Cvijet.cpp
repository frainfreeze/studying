#include "Cvijet.h"

Cvijet::Cvijet(sf::RenderWindow* window) : mainWindow(window) {
	flowerSize = sf::Vector2f(0.2f, 0.2f);
	flowerPos = sf::Vector2f(105, 200);
	
	// make VerParser instance and load model
	if (!spaz.loadVert("data\\models\\simple-cvijet.vert"))
		std::cout << "Failed to load model file.\n";
	// get the container
	bar = spaz.get_container();
}

void Cvijet::draw() {
	// flower
	sf::Texture flowerTexture;
	if (!flowerTexture.loadFromFile("data\\sprites\\flower.jpg")) {
		// we can live without the texture, but warn the user
		std::cerr << "Error loading texture (image)" << std::endl;
	}
	sf::Sprite flowerSprite(flowerTexture);
	flowerSprite.setPosition(flowerPos);
	flowerSprite.setScale(flowerSize);

	// read container into shapes
	VertQuad body;
	if (!body.load(bar))
		std::cerr << "Errorwhile loadig quads!" << std::endl;

	// draw the plant
	mainWindow->draw(body);
	mainWindow->draw(flowerSprite);
}

void Cvijet::setPos(float x, float y) {
	flowerPos += sf::Vector2f(x, y);
}