#include "Cvijet.h"

Cvijet::Cvijet(sf::RenderWindow* window) : mainWindow(window) {
	pedicelColor = sf::Color::Green;
	pedicelSize = sf::Vector2f(100, 6);
	flowerSize = sf::Vector2f(0.2f, 0.2f);
	flowerPos = sf::Vector2f(105, 200);
	pedicelPos = sf::Vector2f(150, 250);
	leafPos0 = sf::Vector2f(145, 320);
	leafPos1 = sf::Vector2f(200, 300);
	leafPos2 = sf::Vector2f(245, 240);
	leafPos3 = sf::Vector2f(180, 270);
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

	// pedicel
	sf::RectangleShape pedicel(pedicelSize);
	pedicel.setFillColor(pedicelColor);
	pedicel.setPosition(pedicelPos);
	pedicel.rotate(90);

	// leaf
	sf::Texture leaftTexture;
	if (!leaftTexture.loadFromFile("data\\sprites\\leaf.jpg")) {
		// we can live without the texture, but warn the user
		std::cerr << "Error loading texture (image)" << std::endl;
	}
	sf::ConvexShape leaf;
	leaf.setPointCount(4);
	leaf.setPoint(0, leafPos0);
	leaf.setPoint(1, leafPos1);
	leaf.setPoint(2, leafPos2);
	leaf.setPoint(3, leafPos3);
	leaf.setFillColor(pedicelColor);
	leaf.setTexture(&leaftTexture);

	// draw the plant
	mainWindow->draw(leaf);
	mainWindow->draw(pedicel);
	mainWindow->draw(flowerSprite);
}

void Cvijet::setPos(float x, float y) {
	flowerPos += sf::Vector2f(x, y);
	pedicelPos += sf::Vector2f(x, y);
	leafPos0 += sf::Vector2f(x, y);
	leafPos1 += sf::Vector2f(x, y);
	leafPos2 += sf::Vector2f(x, y);
	leafPos3 += sf::Vector2f(x, y);
}