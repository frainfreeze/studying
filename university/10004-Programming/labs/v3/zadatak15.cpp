#include <iostream>
using namespace std;

// Zadatak 15 program koji za ucitani cijeli broj racuna te ispisuje njemu obrnuti broj pomnozen s dva (npr. za ucitani broj 123 treba ispisati 642). 
int main()
{
	int broj, broj2;
	int okrenutiBroj = 0;

	cout << "Upisite cijeli broj: ";
	cin >> broj;

	broj2 = broj;

	while (broj2 > 0) {
		okrenutiBroj = (okrenutiBroj * 10) + (broj2 % 10);
		broj2 = broj2 / 10;
	}

	cout << "Ucitani broj je: " << broj << endl;
	cout << "Okrenuti broj je: " << okrenutiBroj << endl;
	cout << okrenutiBroj << " * 2 = " << okrenutiBroj * 2 << endl;

	cout << endl;
	return 0;
}