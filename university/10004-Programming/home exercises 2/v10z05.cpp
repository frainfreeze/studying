#include <iostream> 
#include <string>
#include <vector>
using namespace std;

struct Osoba
{
	string Ime, Prezime, OIB;
};

Osoba GetOsoba()
{
	Osoba o;
	cout << "Ime: ";
	cin >> o.Ime;

	cout << "Prezime: ";
	cin >> o.Prezime;

	cout << "OIB: ";
	cin >> o.OIB;
	return o;
}

void main()
{
	Osoba poljeOsoba[3];
	string oib;

	for (int i = 0; i < 3; i++)
	{
		system("cls");
		poljeOsoba[i] = GetOsoba();
	}	
}