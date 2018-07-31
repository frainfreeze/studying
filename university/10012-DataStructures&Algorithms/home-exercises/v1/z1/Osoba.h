#pragma once

#include <string>
using namespace std;

class Osoba {
public:
	Osoba(string ime, string prezime);
	Osoba(string ime, string prezime, int oib);
	void set_oib(int oib);
	string to_string();
	void draw();
	
private:
	int oib;
	string ime;
	string prezime;
};

