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
		if (!randNum) field[i]=1;
	}
}

void game_of_life::calculate()
{
	std::bitset<800> mask;
	for (unsigned int i = 0; i < 800; ++i) {
		int neighbours = 0;
		if (i >= 41) if (field[i - 41] == 1) neighbours++;
		if (i >= 40) if (field[i - 40] == 1) neighbours++;
		if (i >= 39) if (field[i - 39] == 1) neighbours++;

		if (i >= 1) if (field[i - 1] == 1) neighbours++;
		if (i <= 798) if (field[i + 1] == 1) neighbours++;

		if (i <= 759) if (field[i + 39] == 1) neighbours++;
		if (i <= 759) if (field[i + 40] == 1) neighbours++;
		if (i <= 758) if (field[i + 41] == 1) neighbours++;

		if (neighbours < 2 || neighbours > 3) mask[i] = 0;
		if (neighbours == 3) mask[i] = 1;
		if (field[i] == 1 && neighbours == 2) mask[i] = 1;
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