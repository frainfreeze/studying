#include <fstream>
#include <iostream>
#include <SFML/Graphics.hpp>

void initShape(sf::RectangleShape& shape, sf::Vector2f const& pos, sf::Color const& color) {
	shape.setFillColor(color);
	shape.setPosition(pos);
	shape.setOrigin(shape.getSize() * 0.5f); // the center of rectangle
}

int main(){
	sf::RenderWindow window(sf::VideoMode(700, 400), "small game example");

	// set traget frames per second
	window.setFramerateLimit(60);

	// shapes
	sf::Vector2f startPos = sf::Vector2f(50, 50);
	sf::RectangleShape playerRect(sf::Vector2f(50, 50));
	initShape(playerRect, startPos, sf::Color::Green);

	sf::RectangleShape targetRect(sf::Vector2f(50, 50));
	initShape(targetRect, sf::Vector2f(600, 50), sf::Color::Cyan);

	sf::RectangleShape badRect(sf::Vector2f(50, 150));
	initShape(badRect, sf::Vector2f(300, 50), sf::Color::White);

	// gameloop
	while (window.isOpen()) {

		// handle events
		sf::Event event;
		while (window.pollEvent(event)) {
			
			if (event.key.code == sf::Keyboard::Key::Escape)
				window.close();
			}

		// player input
		if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::Right))
			playerRect.move(1, 0);

		if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::Left))
			playerRect.move(-1, 0);

		if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::Up))
			playerRect.move(0, -1);

		if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::Down))
			playerRect.move(0, 1);

		// target reached
		if (playerRect.getGlobalBounds().intersects(targetRect.getGlobalBounds()))
			window.close();

		// bad rectangle reached
		if (playerRect.getGlobalBounds().intersects(badRect.getGlobalBounds()))
			playerRect.setPosition(startPos);

		// render stuff
		window.clear(sf::Color::Black);
		window.draw(playerRect);
		window.draw(badRect);
		window.draw(targetRect);
		window.display();
	}

	std::cout << "You won!" << std::endl;
	return 0;
}