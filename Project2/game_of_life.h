#ifndef _GAME_OF_LIFE_H_
#define _GAME_OF_LIFE_H_

#include <iostream>
#include <bitset>
#include <ctime>

class game_of_life {
private:
	std::bitset<800> field; //40x20
public:
	game_of_life();
	void calculate();
	void draw();
};
#endif
