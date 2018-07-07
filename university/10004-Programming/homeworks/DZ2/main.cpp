#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

void clearScreen() {
	#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
		system("clear");
	#endif

	#if defined(_WIN32) || defined(_WIN64)
		system("cls");
	#endif
}

struct Automobil {
	string imeAuta;
	string regAuta;
};


int izbornik(vector<Automobil>& automobili);
void ucitajBazu(vector<Automobil>& automobili);
void zapisiBazu(vector<Automobil>& automobili);

void ispis(int foo, vector<Automobil>& automobili);
void unos(string autoZaUnos, string regZaUnos, vector<Automobil>& automobili);
void brisanje(string imeAutaZaBrisanje, vector<Automobil>& automobili);


int main() {
	vector<Automobil> automobili;

	ucitajBazu(automobili);
	while (izbornik(automobili) != -1);
	zapisiBazu(automobili);

	return 0;
}

int izbornik(vector<Automobil>& automobili) {
	clearScreen();
	cout << "Unesite izbor:\n";
	cout << "1. Ispis automobila\n";
	cout << "2. Unos automobila\n";
	cout << "3. Brisanje automobila\n";
	cout << "4. Izlaz\n";

	char temp;
	string tempAuto, tempAuto1;
	cin >> temp;
	cin.ignore();

	switch (temp) {
	case '1':
		ispis(1, automobili);
		break;

	case '2':
		cout << "Unos automobila\n";
		cout << "Unesite vrstu: ";
		getline(cin, tempAuto);
		cout << "Unesite registraciju: ";
		getline(cin, tempAuto1);
		unos(tempAuto, tempAuto1, automobili);
		break;

	case '3':
		ispis(0, automobili);
		cout << "Unesite vrstu automobila za obrisati:";
		getline(cin, tempAuto);
		brisanje(tempAuto, automobili);
		break;

	case '4': return -1;

	default:
		cout << "Neispravan odabir.\n";
		break;
	}
	return 0;
}

void ucitajBazu(vector<Automobil>& automobili) {
	ifstream infile("automobili.txt");
	if (infile.is_open())
	{
		Automobil noviAutomobil;
		while (getline(infile, noviAutomobil.imeAuta, '|') && getline(infile, noviAutomobil.regAuta)) {
			automobili.push_back(noviAutomobil);
		}
		infile.close();
	}
	else cout << "nemogu otvoriti bazu.\n";
}

void zapisiBazu(vector<Automobil>& automobili) {
	ofstream myfile("automobili.txt");
	if (myfile.is_open()) {
		for (unsigned int i = 0; i<automobili.size(); i++) {
			myfile << automobili[i].imeAuta << "|" << automobili[i].regAuta << "\n";
		}
		myfile.close();
	}
	else cout << "nemogu otvoriti bazu.\n";

	cout << "zapisano u bazu\n";
	return;
}

void ispis(int foo, vector<Automobil>& automobili) {
	for (unsigned int i = 0; i<automobili.size(); i++) {
		cout << automobili[i].imeAuta << "(" << automobili[i].regAuta << ")\n";
	}

	if (foo) {
		cout << "Povratak na glavni izbornik\n";
		cin.ignore();
	}
}

void unos(string autoZaUnos, string regZaUnos, vector<Automobil>& automobili) {
	Automobil noviAutomobil;
	noviAutomobil.imeAuta = autoZaUnos;
	noviAutomobil.regAuta = regZaUnos;
	automobili.push_back(noviAutomobil);
	cout << "Automobil uspjesno unesen\n";

	cout << "Povratak na glavni izbornik\n";
	cin.ignore();
}

void brisanje(string imeAutaZaBrisanje, vector<Automobil>& automobili) {
	#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1900)
		// treba c++11 compiler, ako nema radi duzi nacin
		// https://en.wikipedia.org/wiki/Erase%E2%80%93remove_idiom
		automobili.erase(remove_if(automobili.begin(), automobili.end(), 
			[&](Automobil const & automobil) {return automobil.imeAuta == imeAutaZaBrisanje; }), automobili.end());
	#else
		vector<Automobil> tempVec;
		vector<int> indexi;
		for (unsigned int i = 0; i<automobili.size(); i++) {
			if (automobili[i].imeAuta != imeAutaZaBrisanje) indexi.push_back(i);
		}
		for (const int& i : indexi) {
			Automobil tempAutomobil;
			tempAutomobil.imeAuta = automobili[i].imeAuta;
			tempAutomobil.regAuta = automobili[i].regAuta;
			tempVec.push_back(tempAutomobil);
		}
		automobili.swap(tempVec);
	#endif

	cout << "Povratak na glavni izbornik\n";
	cin.ignore();
}