#include <sstream>
#include "Razlomak.h"

Razlomak::Razlomak(int brojnik, int nazivnik)
{
	this->brojnik = brojnik;
	this->nazivnik = nazivnik;
}

void Razlomak::multiply(int x)
{
	this->brojnik *= x;
}

string Razlomak::to_string()
{
	stringstream ss;
	ss << brojnik << "/" << nazivnik;
	return ss.str();
}
