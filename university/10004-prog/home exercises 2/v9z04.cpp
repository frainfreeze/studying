#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Osoba
{
	string Ime, Prezime;
	int GodinaRodjenja;
};

Osoba UnosOsobe(short redniBroj)
{
	system("cls");
	cout << "UNOS OSOBE " << redniBroj << endl << endl;
	Osoba o;
	cout << "Ime: ";
	cin >> o.Ime;

	cout << "Prezime: ";
	cin >> o.Prezime;

	cout << "Godina rodjenja: ";
	cin >> o.GodinaRodjenja;

	return o;
}

void Ispis(Osoba o)
{
	cout << "IME: " << o.Ime << endl;
	cout << "PREZIME: " << o.Prezime << endl;
	cout << "GODINA RODJENJA: " << o.GodinaRodjenja << endl << endl;
}

void main()
{
	Osoba poljeOsoba[3];
	//Unos
	for (int i = 0; i < 3; i++)
	{
		poljeOsoba[i] = UnosOsobe(i+1);
	}
	cout << "For print of persons" << endl;
	system("pause");

	//Ispis
	system("cls");	
	for (int i = 0; i < 3; i++)
	{
		Ispis(poljeOsoba[i]);
	}
	cout << endl << endl;
}