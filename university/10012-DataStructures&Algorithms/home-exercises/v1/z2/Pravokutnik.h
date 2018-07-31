#pragma once
#include <string>

using namespace std;

class Pravokutnik {
public:
	void set_sirina(double sirina);
	void set_visina(double visina);
	double povrsina();
	string to_string();

private:
	double sirina;
	double visina;
};

