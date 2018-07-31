#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <fstream>

#include "Drzava.h"

using namespace std;

int main() 
{

	ifstream is("Broj_znanstvenika_na_milijun_stanovnika.csv");
	if (!is) {
		cout << "Nije moguce pristupiti datoteci" << endl;
		return 1;
	}

	vector<Drzava> drzave;

	string line;
	getline(is, line);
	while (getline(is, line)) {
		stringstream ss(line);
		string naziv;
		getline(ss, naziv, ';');

		Drzava d(naziv);

		string temp;
		for (int i = 0; i < 10; i++) {
            stringstream ss_temp;
            getline(ss, temp, ';');
			ss_temp << temp;
			int broj_znanstvenika;
			if (ss_temp >> broj_znanstvenika) {
				d.dodaj_broj_znanstvenika(broj_znanstvenika);
			}
		}
		drzave.push_back(d);
	}
	is.close();

	for (int i = 0; i < drzave.size(); i++) {
		cout << drzave[i].get_naziv() << " - " << drzave[i].prosjecan_broj_znanstvenika() << endl;
	}

	return 0;
}