// rewrite me!
#include <iostream>
#include <sstream>
#include <fstream>
#include <vector>

#include <SFML/Graphics.hpp>

#include "QuadStruct.h"
#include "VertParse.h"
#include "VertQuad.h"

std::string modelFile = "data\\models\\simple-cvijet.vert";

void inputHandler(sf::Vector2i& click, sf::RenderWindow& window);
static void appendLineToFile(std::string filepath, std::string line);

// global clock for input handler
sf::Clock gClock;

std::vector<sf::Vector2i> tempVec;
std::vector<sf::Vector2i> tempVec2;

std::vector<QuadStruct> bar;
VertParser spaz;
VertQuad test;

int main() {
	sf::ContextSettings settings;
	settings.antialiasingLevel = 8;

	sf::RenderWindow window(sf::VideoMode(1024, 548), "Painter.cpp", sf::Style::Default, settings);

	sf::Vector2i click;

	sf::CircleShape crl1(2); crl1.setFillColor(sf::Color(0, 255, 255)); crl1.setPosition(-5, -5);
	sf::CircleShape crl2(2); crl2.setFillColor(sf::Color(0, 255, 255)); crl2.setPosition(-5, -5);
	sf::CircleShape crl3(2); crl3.setFillColor(sf::Color(0, 255, 255)); crl3.setPosition(-5, -5);

	// onscreen help text
	sf::Font font;
	if (!font.loadFromFile("data\\fonts\\Consolas.ttf"))
		std::cout << "Cant load font!" << std::endl;
	sf::Text text;
	text.setFont(font);
	text.setString(" Left click to place point | Ctrl-Z to undo click | Ctrl-Y to redo click | Ctrl-P to delete everything");
	text.setCharacterSize(12);

	while (window.isOpen()) {

		// handle events
		sf::Event event;
		while (window.pollEvent(event)) {
			if (event.type == sf::Event::Closed)
				window.close();
			if (event.key.code == sf::Keyboard::Key::Escape)
				window.close();
		}


		// load model
		if (!spaz.loadVert(modelFile)) {
			std::cout << "Failed to load model file, making new one.\n";
			std::ofstream myfile;
			myfile.open(modelFile);
			myfile << "# vert model";
			myfile.close();
			if (!spaz.loadVert(modelFile)) {
				std::cout << "Failed to load model file, quiting...\n";
				return -1;
			}
		}
		bar = spaz.get_container();
		if (!test.load(bar)) return -1;

		// render stuff
		//////////////////////////////////////////
		window.clear(sf::Color::Black);
		window.draw(test);
		window.draw(text);

		// position dots, this monstrosity is so undo/redo can work
		crl1.setPosition(-5, -5); crl2.setPosition(-5, -5); crl3.setPosition(-5, -5);
		switch (tempVec.size()) {
		case 1: crl1.setPosition(tempVec[0].x, tempVec[0].y); break;
		case 2: crl1.setPosition(tempVec[0].x, tempVec[0].y);
			crl2.setPosition(tempVec[1].x, tempVec[1].y); break;
		case 3: crl1.setPosition(tempVec[0].x, tempVec[0].y);
			crl2.setPosition(tempVec[1].x, tempVec[1].y);
			crl3.setPosition(tempVec[2].x, tempVec[2].y); break;
		default: break;
		}

		window.draw(crl1); window.draw(crl2); window.draw(crl3);
		window.display();

		inputHandler(click, window);
		std::cout << "Vector size: " << tempVec.size() << std::endl;

		if (tempVec.size() == 4) {
			std::stringstream ss;
			for (unsigned int i = 0; i < tempVec.size(); i++) {
				switch (i) {
				case 0: ss << "\nquad.a.x = " << tempVec[i].x
					<< "\nquad.a.y = " << tempVec[i].y; break;
				case 1: ss << "\nquad.b.x = " << tempVec[i].x
					<< "\nquad.b.y = " << tempVec[i].y; break;
				case 2: ss << "\nquad.c.x = " << tempVec[i].x
					<< "\nquad.c.y = " << tempVec[i].y; break;
				case 3: ss << "\nquad.d.x = " << tempVec[i].x
					<< "\nquad.d.y = " << tempVec[i].y; break;
				default: break;
				}
			}

			// clean
			appendLineToFile(modelFile, ss.str());
			tempVec.clear();
			tempVec2.clear();
		}
	}
	std::cout << "Bye!" << std::endl;
	return 0;
}

static void appendLineToFile(std::string filepath, std::string line) {
	std::ofstream file;

	file.open(filepath, std::ios::out | std::ios::app);
	if (file.fail())
		std::cout << "failed to open destination file." << std::endl;

	//make sure write fails with exception if something is wrong
	file.exceptions(file.exceptions() | std::ios::failbit | std::ifstream::badbit);

	file << line << std::endl;
}

void inputHandler(sf::Vector2i& click, sf::RenderWindow& window) {
	static bool pressed = false;
	while (true) {
		// this is used to refresh window every ~second
		// todo: fix input handler so it doesnt halt the execution
		sf::Time elapsed1 = gClock.getElapsedTime();
		if (elapsed1.asSeconds()>1) {
			gClock.restart();
			return;
		}
		if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) && sf::Keyboard::isKeyPressed(sf::Keyboard::Z)) {
			if (!pressed) {
				click = sf::Mouse::getPosition(window);
				pressed = true;
				sf::Vector2i temp;
				//oh my...
				if (tempVec.size() > 0) {
					temp = tempVec[tempVec.size() - 1];
					tempVec2.push_back(temp);
					tempVec.pop_back();
					break;
				}
			}
		}
		else if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) && sf::Keyboard::isKeyPressed(sf::Keyboard::Y)) {
			if (!pressed) {
				click = sf::Mouse::getPosition(window);
				pressed = true;
				sf::Vector2i temp;
				//oh my...
				if (tempVec2.size()>0) {
					temp = tempVec2[tempVec2.size() - 1];
					tempVec.push_back(temp);
					tempVec2.pop_back();
				}
				break;
			}
		}
		else if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) && sf::Keyboard::isKeyPressed(sf::Keyboard::P)) {
			if (!pressed) {
				click = sf::Mouse::getPosition(window);
				pressed = true;

				std::ofstream myfile;
				myfile.open(modelFile);
				myfile << "# vert model";
				myfile.close();

				break;
			}
		}
		else if (sf::Mouse::isButtonPressed(sf::Mouse::Left)) {
			if (!pressed) {
				click = sf::Mouse::getPosition(window);
				tempVec.push_back(click);
				pressed = true;
				break;
			}
		}
		else {
			pressed = false;
		}
	}
}