#include <iostream>
using namespace std;

/*
program u jedno polje ucita 3 cjela broja u rasponu 1-3, 
u drugo polje ucita 3 cjela broja
prvim poljem definiramo redosljed ispisivanja drugog polja
*/

int main() {

	int polje[3], polje1[3];

	for (int i = 0; i < 3; i++)
	{
		cout << "Unesite " << i + 1 << ". broj redosljeda (1-3): " << endl;
		cin >> polje[i];
	}

	cout << endl;

	for (int i = 0; i < 3; i++)
	{
		cout << "Unesite " << i + 1 << ". broj: " << endl;
		cin >> polje1[i];
	}

	cout << endl;

	for (int i = 0; i < 3; i++)
	{
		cout << polje1[polje[i]-1] << endl;
	}

	cout << endl;

	return 0;
}
