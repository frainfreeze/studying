#pragma once
#include <string>
#include <vector>

class Drzava {
public:
	Drzava(std::string naziv);
	void dodaj_broj_znanstvenika(int n);
	std::string get_naziv();
	double prosjecan_broj_znanstvenika();
	
private:
	std::string naziv;
	std::vector<int> broj_znanstvenika;
};
