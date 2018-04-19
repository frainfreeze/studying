#include "game_of_life.h"

game_of_life::game_of_life()
{
	randomizeField();
}

void game_of_life::randomizeField()
{
	field.reset();
	for (unsigned int i = 0; i < 800; ++i) {
		int randNum = (rand() % 4);
		if (!randNum) field[i] = true;
	}
}

void game_of_life::calculate()
{
	std::bitset<800> mask;
	for (unsigned int i = 0; i < 800; ++i) {
		int neighbours = 0;
		if (i >= 41) if (field[i - 41] == true) neighbours++;
		if (i >= 40) if (field[i - 40] == true) neighbours++;
		if (i >= 39) if (field[i - 39] == true) neighbours++;

		if (i >= 1) if (field[i - 1] == true) neighbours++;
		if (i <= 798) if (field[i + 1] == true) neighbours++;

		if (i <= 759) if (field[i + 39] == true) neighbours++;
		if (i <= 759) if (field[i + 40] == true) neighbours++;
		if (i <= 758) if (field[i + 41] == true) neighbours++;

		if (neighbours < 2 || neighbours > 3) mask[i] = false;
		if (neighbours == 3) mask[i] = true;
		if (field[i] == 1 && neighbours == 2) mask[i] = true;
	}
	field = mask;
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