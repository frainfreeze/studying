#include <iostream>
using namespace std;

int main() {

	int broj, brojac;

	cout << "Uneiste broj: ";
	cin >> broj;

	brojac = 0;

	while (broj != 0) //loop se vrti dok broj ne dode do nule
	{
		broj /= 10; // broj stavljamo na broj = broj / 10, kad podjelimo sa svim deseticama, stoticama etc ostat ce nula i loop ce umrijeti
		brojac++; //povečamo brojač sto znaci da je djeljenje uspilo i da imamo znamenku
	}

	cout << "Broj ima " << brojac << " znamenki.\n";
	return 0;
}