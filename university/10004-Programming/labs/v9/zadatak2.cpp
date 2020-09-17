#include <iostream>
#include <vector>
#include <string>

using namespace std;

struct kolegij {
	string naziv;
	int brojSatiPredavanja;
	int brojSatiVjezbi;
	string asistent;
	string profesor;
};

int main() {
	char temp;
	vector<kolegij> kolegiji;

	do
	{
		kolegij a;
		cout << "Naziv kolegija: ";
		cin >> a.naziv;

		cout << "Broj sati predavanja: ";
		cin >> a.brojSatiPredavanja;

		cout << "Broj sati vjezbi: ";
		cin >> a.brojSatiVjezbi;

		cout << "Ime asistenta: ";
		cin >> a.asistent;

		cout << "Ime profesora: ";
		cin >> a.profesor;

		kolegiji.push_back(a);

		cout << "\nDodati jos kolegija? (d/n)" << endl;
		cin >> temp;
	} while (temp == 'd');

	system("cls");
	cout << "Uneseni kolegiji:\n";
	cout << "-----------------\n";

	for (int i = 0; i < kolegiji.size(); i++)
	{
		cout << "Kolegij: " << kolegiji[i].naziv << endl;
		cout << "Broj sati predavanja: " << kolegiji[i].brojSatiPredavanja << endl;
		cout << "Broj sati vjezbi: " << kolegiji[i].brojSatiVjezbi << endl;
		cout << "Asistent: " << kolegiji[i].asistent << endl;
		cout << "Profesor: " << kolegiji[i].profesor << endl;
		cout << "-----------------\n";
	}

	return 0;
}