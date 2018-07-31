#include <cmath>
#include "Tocka.h"

Tocka::Tocka() : x(0), y(0)
{}

void Tocka::init(int x, int y)
{
	this->x = x;
	this->y = y;
}

double Tocka::distance()
{
	return sqrt(pow(x, 2) + pow(y, 2));
}

int Tocka::get_x()
{
	return x;
}

int Tocka::get_y()
{
	return x;
}
