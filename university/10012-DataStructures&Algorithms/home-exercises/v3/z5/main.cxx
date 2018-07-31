#include <iostream>
#include <sstream>
#include <string>
#include <fstream>

using namespace std;

int main() 
{
	ifstream is("Broj_znanstvenika_na_milijun_stanovnika.csv");

	if (!is) {
		cout << "Nije moguce pristupiti datoteci" << endl;
		return 1;
	}

	string line;
	getline(is, line);
	while (getline(is, line)) {
		stringstream ss(line);
		string naziv;
		getline(ss, naziv, ';');

		string temp;
		bool nema_podataka = true;
		for (int i = 0; i < 10; i++) {
            stringstream converter;
            getline(ss, temp, ';');			            
			converter << temp;
			int broj_znanstvenika;
			if (converter >> broj_znanstvenika) {
				nema_podataka = false;
				break;
			}
		}

		if (nema_podataka) {
			cout << naziv << endl;
		}
	}
	is.close();

	return 0;
}