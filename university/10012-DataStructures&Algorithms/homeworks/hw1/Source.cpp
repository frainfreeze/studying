#include <iostream>
#include <SFML/Graphics.hpp>
#include "Cvijet.h"

int main(){
	sf::ContextSettings settings;
	settings.antialiasingLevel = 8;

	// make window, set framerate, instantiate clock
	sf::RenderWindow window(sf::VideoMode(1024, 548), "DS&A homework", sf::Style::Default, settings);
	window.setFramerateLimit(60);
	sf::Clock clock1;

	// initialize flower object and position it
	Cvijet cvijet(&window);
	cvijet.setPos(700, 155);

	while (window.isOpen()){

		const sf::Time deltaTime = clock1.restart();
		sf::Event event; // handle input

		while (window.pollEvent(event)){
			// close window with mouse or esc
			if (event.type == sf::Event::Closed)
				window.close();
			if (event.key.code == sf::Keyboard::Key::Escape)
				window.close();
		}

		window.clear();
		cvijet.draw(deltaTime);
		window.display();
	}
	return 0;
}