#include <iostream>
#include <string>
#include <vector>
using namespace std;

float PDV = 0.25;

struct Racun
{
	string BrojRacuna;
	float Iznos, PDV;
};

Racun KreirajRacun()
{
	Racun r;
	string brojRacuna;
	system("cls");

	cout << "UNOS RACUNA" << endl << endl;
	cout << "Unesite broj racuna: ";
	getline(cin, brojRacuna);
	r.BrojRacuna = brojRacuna;

	cout << "Iznos racuna: ";
	cin >> r.Iznos;

	r.PDV = r.Iznos * PDV;
	return r;
}

void Ispis(vector<Racun> racuni)
{
	system("cls");
	float ukupnoIznos = 0;
	float ukupnoPDV = 0;
	cout << "ISPIS UNESENIH RACUNA" << endl << endl;
	for (int i = 0; i < racuni.size(); i++)
	{
		cout << "BROJ RACUNA: " << racuni[i].BrojRacuna << endl;
		cout << "IZNOS RACUNA: " << racuni[i].Iznos << "kn" << endl;
		cout << "PDV: " << racuni[i].PDV << "kn" << endl << endl;
		ukupnoIznos += racuni[i].Iznos;
		ukupnoPDV += racuni[i].PDV;		
	}
	cout << "----------------------------------------" << endl;
	cout << "\nUKUPNO IZNOS: " << ukupnoIznos << "kn" << endl;
	cout << "UKUPNO PDV: " << ukupnoPDV << "kn" << endl;
}

void main()
{
	char ponovi;
	vector<Racun> kolekcijaRacuna;

	do
	{
		kolekcijaRacuna.push_back(KreirajRacun());
		cout << "Dodati jos racuna(d/n): ";
		cin >> ponovi;
		cin.ignore();
	} while (ponovi == 'd');

	Ispis(kolekcijaRacuna);
	cout << endl << endl;
}