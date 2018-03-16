#include <SFML/Graphics.hpp>
#include <iostream>
#include "Cvijet.h"

//#define DEBUG

//helper function to figure out where to paint the flower
void pprint(sf::Vector2i localPosition) { 
	std::cout << localPosition.x << ", " << localPosition.y << std::endl; 
}

int main(){
	// make window and set framerate
	sf::RenderWindow window(sf::VideoMode(1024, 548), "DS&A homework");
	window.setFramerateLimit(60);

	// load background
	sf::Texture texture1;
	sf::Texture texture2;
	if ((!texture1.loadFromFile("data\\sprites\\background.jpg")) || (!texture2.loadFromFile("data\\sprites\\background_tree.png"))) {
		std::cerr << "Failed to load background pictures, exiting..." << std::endl;
		return -1;
	}
	sf::Sprite background(texture1);
	sf::Sprite backgroundTree(texture2);

	// load  distortionMap for shader
	sf::Texture distortionMap;
	distortionMap.setRepeated(true);
	distortionMap.setSmooth(true);
	if (!distortionMap.loadFromFile("data\\sprites\\distortion_map.png")) {
		std::cerr << "Failed to load distortion map, exiting..." << std::endl;
		return -1;
	}
	// load and setup shaders
	sf::Shader shader;
	if (!shader.loadFromFile("data\\shaders\\heat_shader.vs", "data\\shaders\\heat_shader.fs")) {
		std::cerr << "Failed to load shader, exiting..." << std::endl;
		return -1;
	}
	shader.setUniform("currentTexture", sf::Shader::CurrentTexture);
	shader.setUniform("distortionMapTexture", distortionMap);
	float distortionFactor = .007f; // Shader, Fragment Shader
	float riseFactor = .04f;

	// load animation frames (this is disgusting at the moment)
	// todo: animation class that works with spritesheets
	sf::Texture cloak1Tex;
	sf::Texture cloak2Tex;
	sf::Texture cloak3Tex;
	sf::Texture cloak4Tex;
	sf::Texture cloak5Tex;
	if ((!cloak1Tex.loadFromFile("data\\sprites\\cloack5.png")) ||
		(!cloak2Tex.loadFromFile("data\\sprites\\cloack4.png")) ||
		(!cloak3Tex.loadFromFile("data\\sprites\\cloack3.png")) ||
		(!cloak4Tex.loadFromFile("data\\sprites\\cloack1.png")) ||
		(!cloak5Tex.loadFromFile("data\\sprites\\cloack0.png"))) {
		std::cerr << "Failed to load animation pictures, exiting..." << std::endl;
		return -1;
	}
	sf::Sprite cloak;

	// anim
	int numFrames = 8;
	float animDuration = .95f;

	// initialize clocks for shader and animations
	sf::Clock clock;
	sf::Clock clock1;
	sf::Time elapsedTime;

	// initialize flower object and possition it
	Cvijet cvijet(&window);
	cvijet.setPos(700, 145);

	while (window.isOpen()){
		// returns elapsed time and restarts the clock
		sf::Time deltaTime = clock1.restart();

		// handle input
		sf::Event event;
		while (window.pollEvent(event)){
			// close window with mouse or esc
			if (event.type == sf::Event::Closed)
				window.close();
			if (event.key.code == sf::Keyboard::Key::Escape)
				window.close();
		}

		// shader
		shader.setUniform("time", clock.getElapsedTime().asSeconds());
		shader.setUniform("distortionFactor", distortionFactor);
		shader.setUniform("riseFactor", riseFactor);

		//mouse coords
		#ifdef DEBUG
			sf::Vector2i localPosition = sf::Mouse::getPosition(window);
			pprint(localPosition);
		#endif

		//acumulate time with each frame
		elapsedTime += deltaTime;
		float timeAsSeconds = elapsedTime.asSeconds();

		// get current animation frame
		int animFrame = static_cast<int>((timeAsSeconds / animDuration)*numFrames) % numFrames;

		///////////////////////////////////////////////////
		// render
		///////////////////////////////////////////////////
		window.clear();

		window.draw(background);
		// using heatwave shader to simulate wind
		window.draw(backgroundTree, &shader);
		cvijet.draw();

		// render animation frame depending on frame
		// this is the worst thing i have ever done.
		switch (animFrame){
		case 1: cloak.setTexture(cloak1Tex); break;
		case 2: cloak.setTexture(cloak2Tex); break;
		case 3: cloak.setTexture(cloak3Tex); break;
		case 4: cloak.setTexture(cloak4Tex); break;
		case 5: cloak.setTexture(cloak5Tex); break;
		case 6: cloak.setTexture(cloak4Tex); break;
		case 7: cloak.setTexture(cloak3Tex); break;
		case 8: cloak.setTexture(cloak2Tex); break;
		default: break;
		}
		window.draw(cloak);

		window.display();
		///////////////////////////////////////////////////
	}
	return 0;
}