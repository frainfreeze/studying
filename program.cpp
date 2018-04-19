#include <iostream>
#include "game_of_life.h"

int main() {
	srand(static_cast<unsigned int>(time(nullptr)));
	game_of_life the_game;

	int nxt;
	do {
		the_game.draw();
		the_game.calculate();

		std::cout << "\n\tQuit/Next/Reset (0/1/2): ";		
		std::cin >> nxt;
		
		if (nxt == 2) the_game.randomizeField();
	} while (nxt);

	return 0;
}