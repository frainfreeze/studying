#include <sstream>
#include "Pravokutnik.h"

void Pravokutnik::set_sirina(double sirina)
{
	this->sirina = sirina;
}

void Pravokutnik::set_visina(double visina)
{
	this->visina = visina;
}

double Pravokutnik::povrsina()
{
	return sirina * visina;
}

string Pravokutnik::to_string()
{
	stringstream ss;
	ss << "P(" << sirina << ", " << visina << ") = " << povrsina();
	return ss.str();
}
