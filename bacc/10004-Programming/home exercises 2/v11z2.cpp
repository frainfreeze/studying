#include <iostream>
#include <vector>
#include <string>
using namespace std;

void main()
{
	int polje[3];

	/*
		Ime polja predstavlja memorijsku adresu prvog elementa polja
		Pristupanje vrijednostima elemenata polja:
		*(polje + 0)
		*(polje + 1)
		*(polje + 2)
		* je "jaci" operator od + pa se sve skupa stavlja u zagradu
		...
		ili
		polje[0]
		polje[1]
		polje[2]
	*/

	for (int i = 0; i < 3; i++)
	{
		cout << "Unesite " << (i + 1) << ".broj: ";
		cin >> *(polje + i);
	}

	/*	Ispis u obrnutom redoslijedu  */

	for (int i = 2; i >= 0; i--)
	{
		cout << *(polje + i) << endl;
	}

}