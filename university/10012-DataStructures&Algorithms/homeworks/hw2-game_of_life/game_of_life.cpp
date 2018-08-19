#include "game_of_life.h"

game_of_life::game_of_life()
{
	for (unsigned int i = 0; i < f.size(); ++i)
		if (!(rand() % 4)) 
			f[i] = true;
}

void game_of_life::calculate()
{
	std::bitset<800> nf;
	for (int i = 0; i < f.size(); ++i) {
		int n = 0;
		n += ((i > 40 && f[i - 41]) + (i > 39 && f[i - 40]) + (i > 38 && f[i - 39]) + (i > 0 && f[i - 1]) + (i < 799 && f[i + 1]) + (i < 761 && f[i + 39]) + (i < 760 && f[i + 40]) + (i < 759 && f[i + 41]));
		n < 2 || n>3 ? nf[i] = false : (n == 3) || (f[i] == 1 && n == 2) ? nf[i] = true : 0;
	}
	f = nf;
}

void game_of_life::draw()
{
	system("cls");
	for (unsigned int i = 0; i < f.size(); ++i)
		!(i % 40) ? std::cout << "\n" : f[i] ? std::cout << "#" : std::cout << " ";
}