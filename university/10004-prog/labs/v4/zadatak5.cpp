#include <iostream>
using namespace std;

/*
Napisite program koji s tipkovnice ucitava 5 cijelih brojeva u polje, jos jedan cijeli broj, te
ispisuje ostatke svakog broja iz polja pri dijeljenju s njim
*/

int main() {

	int brojevi[5], broj;

	for (int i = 0; i < 5; i++)
	{
		cout << "Unesite broj: " << endl;
		cin >> brojevi[i];
	}

	cout << endl;

	cout << "unesite jos jedan cijeli br0j: " << endl;
	cin >> broj;

	cout << endl;

	for (int i = 0; i < (sizeof(brojevi) / sizeof(brojevi[0])); i++) {
		int ostatak = brojevi[i] % broj;

		if (i == (sizeof(brojevi) / sizeof(brojevi[0])) - 1) {
			cout << brojevi[i] << " % " << broj << " = " << ostatak << ".";
			break;
		}

		cout << brojevi[i] << " % " << broj << " = " << ostatak << ", " << endl;

	}

	cout << endl;

	return 0;
}
