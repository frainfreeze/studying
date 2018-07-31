#include <sstream>
#include <iostream>
#include "Osoba.h"

Osoba::Osoba(string ime, string prezime)
{
	this->ime = ime;
	this->prezime = prezime;
}

Osoba::Osoba(string ime, string prezime, int oib) : Osoba(ime, prezime)
{
	set_oib(oib);
}

void Osoba::set_oib(int oib)
{
	this->oib = oib;
}

string Osoba::to_string()
{
	stringstream ss;
	ss << prezime << " " << ime << "(" << oib << ")";
	return ss.str();
}

void Osoba::draw()
{
	cout << "      \\|||/" << endl;
	cout << "      (o o)" << endl;
	cout << ",~ooO~~(_)~~~~~~," << endl;
	cout << "|               |" << endl;
	cout << "|               |" << endl;
	cout << ime << "  " << prezime << endl;
	cout << "     |__|__|    " << endl;
	cout << "      || ||     " << endl;
	cout << "     ooO Ooo    " << endl;

}
