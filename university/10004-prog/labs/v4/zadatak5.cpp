#include <iostream>
using namespace std;

/* naka korisnik unese 5 brojeva koji ce se spremiti u niz i neka unese jos jedan cijeli broj. 
program treba ispisati rezultat djeljenja svih brojeva niza tim brojem*/

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
		if (i == (sizeof(brojevi) / sizeof(brojevi[0])) - 1) {
			cout << brojevi[i]/broj << ".";
			break;
		}

		cout << brojevi[i]/broj << ", ";

	}

	cout << endl;

	return 0;
}
