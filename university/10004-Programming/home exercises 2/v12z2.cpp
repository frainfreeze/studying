#include <iostream>
#include <string>
using namespace std;

struct Knjiga
{
	string Autor, Naslov;
	int BrojStranica;
};

void UcitajKnjige(Knjiga* kolekcijaKnjiga, int velicinaKolekcije)
{
	for (int i = 0; i < velicinaKolekcije; i++)
	{
		cout << "KNJIGA " << (i + 1) << endl;
		cout << "Autor: ";
		getline(cin, kolekcijaKnjiga[i].Autor);

		cout << "Naslov: ";
		getline(cin, kolekcijaKnjiga[i].Naslov);

		cout << "Broj stranica: ";
		cin >> kolekcijaKnjiga[i].BrojStranica;
		cin.ignore();
		system("cls");
	}
}

void IspisKnjiga(Knjiga* kolekcijaKnjiga, int velicinaKolekcije)
{
	for (int i = 0; i < velicinaKolekcije; i++)
	{
		cout << (i + 1) << ".KNJIGA" << endl;
		cout << "Autor: " << kolekcijaKnjiga[i].Autor << endl;
		cout << "Naslov: " << kolekcijaKnjiga[i].Naslov << endl;
		cout << "Broj stranica: " << kolekcijaKnjiga[i].BrojStranica << endl;
		cout << endl;
	}
}

void DefinirajNajtanjuiNajdebljuKnjigu(Knjiga* kolekcijaKnjiga, Knjiga* najtanja, Knjiga* najdeblja, int velicinaKolekcije)
{
	int min = kolekcijaKnjiga[0].BrojStranica;
	int max = kolekcijaKnjiga[0].BrojStranica;

	for (int i = 0; i < velicinaKolekcije; i++)
	{
		if (kolekcijaKnjiga[i].BrojStranica < min)
		{
			min = kolekcijaKnjiga[i].BrojStranica;
			*najtanja = kolekcijaKnjiga[i];
		}
		if (kolekcijaKnjiga[i].BrojStranica > max)
		{
			max = kolekcijaKnjiga[i].BrojStranica;
			*najdeblja = kolekcijaKnjiga[i];
		}
	}
}

void main()
{
	Knjiga kolekcijaKnjiga[3];
	Knjiga NajtanjaKnjiga, NajdebljaKnjiga;
	
	UcitajKnjige(kolekcijaKnjiga, 3);
	IspisKnjiga(kolekcijaKnjiga, 3);
	cout << endl;

	DefinirajNajtanjuiNajdebljuKnjigu(kolekcijaKnjiga, &NajtanjaKnjiga, &NajdebljaKnjiga, 3);
	cout << "NAJTANJA: " << NajtanjaKnjiga.Naslov << endl;
	cout << "NAJDEBLJA: " << NajdebljaKnjiga.Naslov << endl;
}