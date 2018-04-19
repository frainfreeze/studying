#include "game_of_life.h"

game_of_life::game_of_life()
{
	for (unsigned int i = 0; i < 800; ++i) {
		if (!(rand() % 4)) field[i] = true;
	}
}

void game_of_life::calculate()
{
	std::bitset<800> nxtField;
	for (unsigned int i = 0; i < 800; ++i) {
		int neighbours = 0;
		if (i > 40) if (field[i - 41] == true) neighbours++;
		if (i > 39) if (field[i - 40] == true) neighbours++;
		if (i > 38) if (field[i - 39] == true) neighbours++;

		if (i > 0) if (field[i - 1] == true) neighbours++;
		if (i < 799) if (field[i + 1] == true) neighbours++;

		if (i < 761) if (field[i + 39] == true) neighbours++;
		if (i < 760) if (field[i + 40] == true) neighbours++;
		if (i < 759) if (field[i + 41] == true) neighbours++;

		if (neighbours < 2 || neighbours > 3) nxtField[i] = false;
		if (neighbours == 3) nxtField[i] = true;
		if (field[i] == 1 && neighbours == 2) nxtField[i] = true;
	}
	field = nxtField;
}

void game_of_life::draw()
{
	system("cls");
	for (unsigned int i = 0; i < 800; ++i) {
		if (i % 40 == 0) {
			std::cout << "\n";
			continue;
		}
		field[i] ? std::cout << "#" : std::cout << " ";
	}
}