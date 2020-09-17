#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Kolegij
{
	string Naziv, Profesor, Asistent;
	short satiPredavanja, satiVjezbi;
};

Kolegij KreirajKolegij()
{
	Kolegij k;

	cout << "Unesite naziv kolegija: ";
	getline(cin, k.Naziv);

	cout << "Unesite ime profesora: ";
	getline(cin, k.Profesor);

	cout << "Unesite ime asistenta: ";
	getline(cin, k.Asistent);

	cout << "Unesite broj sati predavanja: ";
	cin >> k.satiPredavanja ;

	cout << "Unesite broj sati vjezbi: ";
	cin >> k.satiVjezbi;
	
	return k;
}

void IspisKolegija(Kolegij k)
{
	cout << "KOLEGIJ: " << k.Naziv << endl;
	cout << "PROFESOR: " << k.Profesor << endl;
	cout << "ASISTENT: " << k.Asistent << endl;
	cout << "SATI PREDAVANJA: " << k.satiPredavanja << endl;
	cout << "SATI VJEZBI: " << k.satiVjezbi << endl;
}

void main()
{
	char ponovi;
	vector<Kolegij> kolekcijaKolegija;
	do
	{
		system("cls");
		cout << "UNOS KOLEGIJA" << endl << endl;

		kolekcijaKolegija.push_back(KreirajKolegij());

		cout << "Dodati jos kolegija (d/n): ";
		cin >> ponovi;
		cin.ignore();
	} while (ponovi == 'd');
	
	system("cls");

	cout << "ISPIS UPISANIH KOLEGIJA" << endl;
	for (int i = 0; i < kolekcijaKolegija.size(); i++)
	{
		IspisKolegija(kolekcijaKolegija[i]);
	}
}