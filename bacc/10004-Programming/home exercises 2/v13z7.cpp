#include <iostream>
#include <string>
using namespace std;

int main() {

	// U�itavanje u obi�no polje.
	int brojevi[5];
	for (int i = 0; i < 5; i++) {
		cout << "Broj: ";
		cin >> brojevi[i];
	}

	// Brojanje parnih.
	int ukupno_parnih = 0;
	for (int i = 0; i < 5; i++) {
		if (brojevi[i] % 2 == 0) {
			ukupno_parnih++;
		}
	}

	// Prepisivanje parnih u dinami�ko polje.
	int* parni = new int[ukupno_parnih];
	int trenutni = 0;

	for (int i = 0; i < 5; i++) {
		if (brojevi[i] % 2 == 0) {
			parni[trenutni] = brojevi[i];
			trenutni++;
		}
	}

	// Ispis iz dinami�kog polja.
	for (int i = 0; i < ukupno_parnih; i++) {
		cout << parni[i] << " ";
	}
	cout << endl;

	delete[] parni;

	return 0;
}