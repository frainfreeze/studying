#include <iostream>
using namespace std;

// Zadatak 4. Napisite funkciju koja vraca broj znamenaka cijelog broja.

int BrojZnamenakaBroja(int broj) {
	int brojac = 0;
	while (broj != 0) {
		broj = broj / 10;
		brojac++;
	}
	return brojac;
}


int main() {

	int a;

	cout << "Unesite broj: ";
	cin >> a;

	cout << "Broj " << a << " ima " << BrojZnamenakaBroja(a) << " znamenaka." << endl;

	return 0;
}
