#include <iostream>
#include <fstream>

#include <SFML/Graphics.hpp>
#include <QuadStruct.h>
#include "VertParse.h"
#include "VertQuad.h"

struct ClickType{
    sf::Vector2i position;
    std::string type;
};

sf::Vector2i inputHandler(ClickType& click, sf::RenderWindow& window);

int main(){
    // generate test file
    //generate_sample_model("test1.vert");

    // create QuadContainer to test parser
    QuadContainer bar;

    // make VerParser instance and load model
    VertParser spaz;
    spaz.loadVert("test1.vert");

    // test the parser
    bar = spaz.get_container();

    // magic <3
    VertQuad test;
    if (!test.load(bar)) return -1;

    sf::RenderWindow window(sf::VideoMode(700, 400), "shape loader test");
	window.setFramerateLimit(60);
    ClickType click;

	while (window.isOpen()) {

		// handle events
		sf::Event event;
		while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed)
                window.close();
			if (event.key.code == sf::Keyboard::Key::Escape)
				window.close();
		}

        auto position = inputHandler(click, window);
        std::cout << "x: " << click.position.x << ", y: " << click.position.y << ", type: " << click.type <<'\n';


		// render stuff
		window.clear(sf::Color::Black);
		window.draw(test); // testing
		window.display();
	}

	std::cout << "Bye!" << std::endl;
    return 0;
}


sf::Vector2i inputHandler(ClickType& click, sf::RenderWindow& window){
    static bool pressed=false;
    while (true){
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) && sf::Keyboard::isKeyPressed(sf::Keyboard::Z)){
          if (!pressed){
            click.position = sf::Mouse::getPosition(window);
            click.type = "Ctrl-Z";
            pressed=true;
            break;
          }
      }
      else if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) && sf::Keyboard::isKeyPressed(sf::Keyboard::Y)){
          if (!pressed){
            click.position = sf::Mouse::getPosition(window);
            click.type = "Ctrl-Y";
            pressed=true;
            break;
          }
      }
      else if (sf::Mouse::isButtonPressed(sf::Mouse::Left)){
          if (!pressed){
            click.position = sf::Mouse::getPosition(window);
            click.type = "Left Click";
            pressed=true;
            break;
          }
      }
      else if (sf::Mouse::isButtonPressed(sf::Mouse::Right)){
          if (!pressed){
            click.position = sf::Mouse::getPosition(window);
            click.type = "Right Click";
            pressed=true;
            break;
          }
      }
      else{
        pressed = false;
      }
    }
}
