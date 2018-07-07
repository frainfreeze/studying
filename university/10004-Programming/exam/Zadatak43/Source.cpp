#include <iostream>
#include <string>
using namespace std;

struct Automobil {
	string brTablice;
	string imeVl;
	string prezimeVl;
};

int main() {
	Automobil automobili[5] = {
		{ "zg-000-aa","Ivan","Horvat" },
		{ "ri-234-tk","Luka","Brusic" },
		{ "vk-234-sd","Marija","Kovac" },
		{ "zg-546-ui","Dorijan","Zec" },
		{ "zg-657-bd","Iva","Zuzic" }
	};

	bool nastaviti = true;
	char temp;
	string tempTabl;
	do
	{
		cout << "Upisite trazeni broj tablice: ";
		getline(cin, tempTabl);

		bool pronadeno = false;

		for (auto & i : automobili) {
			if (i.brTablice == tempTabl) {
				pronadeno = true;
				cout << "Ime vlasnika tablice: " << i.imeVl
					<< "\nPrezime vlasnika tablice: " << i.prezimeVl << endl;
			}
		}

		if (!pronadeno) cout << "Trazeni broj tablice ne postoji!\n";

		cout << "Nastaviti? (d/n)";
		cin >> temp;
		if (temp != 'd') nastaviti = false;
		cin.ignore();
	} while (nastaviti);

	return 0;
}
