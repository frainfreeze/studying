#include "Drzava.h"

Drzava::Drzava(std::string naziv) 
{
	this->naziv = naziv;
}

void Drzava::dodaj_broj_znanstvenika(int n) 
{
	this->broj_znanstvenika.push_back(n);
}

std::string Drzava::get_naziv() 
{
	return naziv;
}

double Drzava::prosjecan_broj_znanstvenika() 
{
	if (broj_znanstvenika.size() == 0) {
		return 0;
	}
	
	double suma = 0;

	for (int i = 0; i < broj_znanstvenika.size(); i++) {
		suma += broj_znanstvenika[i];
	}

	return suma / broj_znanstvenika.size();
}
