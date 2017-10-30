#include <iostream>
using namespace std;

// Zadatak 16 Potrebno je ispisati djelitelje odabranog prirodnog broja. Po unosu broja treba provjeriti da li je uneseni broj prirodan, ako nije valja ponoviti unos. 
int main()
{
	int brojac, prirodniBroj;

	do {
		cout << "Upisi prirodni broj: ";
		cin >> prirodniBroj;
	} while (prirodniBroj < 0);

	cout << "Djelitelji broja " << prirodniBroj << " su: ";

	for (brojac = 1; brojac <= prirodniBroj; brojac++)
	{
		if (prirodniBroj % brojac == 0)
			cout << brojac << " ";
	}

	cout << endl;
	return 0;
}