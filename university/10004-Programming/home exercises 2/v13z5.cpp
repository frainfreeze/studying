#include <iostream>
#include <string>
using namespace std;

void IspisiRecenicuObrnuto(string recenica)
{
	for (int i = recenica.size() - 1; i >= 0; i--) {
		cout << recenica[i];
	}
	cout << endl;
}


void main()
{
	int brojImena;

	cout << "Koliko imena cete ucitati: ";
	cin >> brojImena;
	cin.ignore();

	string* poljeImena = new string[brojImena];

	/* U�itaj imena */
	for (int i = 0; i < brojImena; i++)
	{
		cout << "Unesite " << (i + 1) << ". ime: ";
		getline(cin, poljeImena[i]);
	}
	cout << endl;
	cout << "ISPIS" << endl << endl;
	/* Ispi�i obrnuta imena */
	for (int i = 0; i < brojImena; i++)
	{
		IspisiRecenicuObrnuto(poljeImena[i]);
	}
	delete[] poljeImena;
	cout << endl;
}