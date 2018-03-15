#include <fstream>
#include <iostream>
#include <SFML/Graphics.hpp>


int main(){
	sf::RenderWindow window(sf::VideoMode(300, 200), "Title");
	sf::String buffer;

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
				if (event.key.code == sf::Keyboard::Key::Space)
					window.setTitle("space");
				if (event.key.code == sf::Keyboard::Key::Escape)
					window.close();
				break;

			case sf::Event::EventType::TextEntered:
				buffer += event.text.unicode;
				window.setTitle(buffer);
				break;
			}
		}

		// update scene

		// render cycle
		window.clear(sf::Color::Magenta);

		// render objects
		window.display();
	}

	return 0;
}