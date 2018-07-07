#include <iostream>
#include <vector>
using namespace std;

/*
Zadatak 1. Napisite program koji od korisnika ucitavati neogranicen 
		   broj cijelih brojeva. Nakon unosa ispisite brojeve.
*/

int main() {

    char ponoviUnos;

	vector<int> poljeBrojeva;

	do {
		int broj;
		cout << "Unesite broj: ";
		cin >> broj;
		poljeBrojeva.push_back(broj);

		cout << "Dodati jos brojeva u polje? (d/n)" << endl;
		cin >> ponoviUnos;
	} while (ponoviUnos == 'd');

	for (int i = 0; i < size(poljeBrojeva); i++)
	{
		if (i != poljeBrojeva.size() - 1) {
			cout << poljeBrojeva[i] << ", ";
		} else {
		cout << poljeBrojeva[i] << ".";
		}
	}
	cout << endl;
	return 0;
}