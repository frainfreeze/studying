#include <fstream>
#include <iostream>
#include <SFML/Graphics.hpp>


int main(){
	sf::RenderWindow window(sf::VideoMode(300, 200), "Title");

	// shapes
	sf::CircleShape circleShape(50);
	circleShape.setFillColor(sf::Color::Red);
	circleShape.setOutlineColor(sf::Color::Blue);
	circleShape.setOutlineThickness(3);
	circleShape.setPosition(sf::Vector2f(0, 10));

	sf::RectangleShape rectShape(sf::Vector2f(50, 50));
	rectShape.setFillColor(sf::Color::Green);
	rectShape.setPosition(sf::Vector2f(150, 50));
	rectShape.setRotation(45);
	rectShape.setScale(sf::Vector2f(2, 1));

	sf::ConvexShape triangle;
	triangle.setPointCount(3);
	triangle.setPoint(0, sf::Vector2f(100, 0));
	triangle.setPoint(1, sf::Vector2f(100, 100));
	triangle.setPoint(2, sf::Vector2f(0, 100));
	triangle.setFillColor(sf::Color::Blue);
	triangle.setPosition(sf::Vector2f(0, 100));

	// gameloop
	while (window.isOpen()) {

		// handle events
		sf::Event event;
		while (window.pollEvent(event)) {
			switch (event.type) {
			case sf::Event::EventType::Closed:
				window.close();
				break;

			case sf::Event::EventType::KeyPressed:
				if (event.key.code == sf::Keyboard::Key::Escape)
					window.close();
				break;
			}
		}

		// update scene

		// render cycle
		window.clear(sf::Color::Magenta);
		window.draw(circleShape);
		window.draw(rectShape);
		window.draw(triangle);

		// render objects
		window.display();
	}

	return 0;
}