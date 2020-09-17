#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Posudba
{
	string Clan, Film;
};

Posudba UnosPosudbe(){
	Posudba p;

	cout << "Ime i prezime clana: ";
	getline(cin, p.Clan);

	cout << "Film koji je posudio: ";
	getline(cin, p.Film);

	return p;
}

void ZaglavljeAplikacije(short brojPosudbi)
{
	system("cls");
	cout << "VIDEOTEKA" << endl;
	cout << "Trenutno posudjeno filmova: " << brojPosudbi << endl << endl;
}

void Ispis(vector<Posudba> posudbe)
{
	ZaglavljeAplikacije(posudbe.size());

	cout << "1.Ispisi sve posudbe" << endl;
	cout << "2.Ispisi odredjenu posudbu" << endl;
	cout << "Vas izbor: ";

	short odabirIspisa;
	cin >> odabirIspisa;
	cout << endl << endl;

	switch (odabirIspisa)
	{
		case 1:
			for (int i = 0; i < posudbe.size(); i++)
			{
				cout << "Posudba " << (i+1) << endl;
				cout << "CLAN: " << posudbe[i].Clan << endl;
				cout << "FILM: " << posudbe[i].Film << endl << endl;				
			}
			break;
		case 2:
			short redniBroj;
			cout << "Redni broj posudbe [1-" << posudbe.size() << "]: ";			
			cin >> redniBroj;
			cout << "CLAN: " << posudbe[redniBroj - 1].Clan << endl;
			cout << "FILM: " << posudbe[redniBroj - 1].Film << endl;
			break;
	default:
		Ispis(posudbe);
		break;
	}
}

void main()
{
	char ponovi;
	vector<Posudba> kolekcijaPosudbi;
	do
	{
		ZaglavljeAplikacije(kolekcijaPosudbi.size());	
		kolekcijaPosudbi.push_back(UnosPosudbe());

		cout << "Unijeti jos jednu posubu (d/n): ";
		cin >> ponovi;
		cin.ignore();
	} while (ponovi == 'd');	
	
	Ispis(kolekcijaPosudbi);	
}