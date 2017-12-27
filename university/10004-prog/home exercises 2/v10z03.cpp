#include <iostream> 
#include <string>
#include <vector>
using namespace std;

struct Adresa
{
	string Ulica, Grad;
	int KucniBroj;
};
struct Trgovina
{
	string Naziv;
	Adresa Adresa;
	int BrojPoslovnica;
};
Trgovina GetTrgovina()
{
	Trgovina t;
	cout << "Naziv: ";
	cin >> t.Naziv;

	cout << "Ulica: ";
	cin >> t.Adresa.Ulica;
	
	cout << "Kucni broj: ";
	cin >> t.Adresa.KucniBroj;
	
	cout << "Grad: ";
	cin >> t.Adresa.Grad;

	cout << "Broj poslovnica: ";
	cin >> t.BrojPoslovnica;
	return t;
}
void Ispis(vector<Trgovina> kolekcijaTrgovina)
{
	for (int i = 0; i < kolekcijaTrgovina.size(); i++)
	{
		cout << "Naziv: " << kolekcijaTrgovina[i].Naziv << endl;
		cout << "Adresa: " << kolekcijaTrgovina[i].Adresa.Ulica << kolekcijaTrgovina[i].Adresa.KucniBroj << ", " << kolekcijaTrgovina[i].Adresa.Grad << endl;
		cout << "Broj poslovnica: " << kolekcijaTrgovina[i].BrojPoslovnica << endl;
	}
}
void main2()
{
	vector<Trgovina> kolekcijaTrgovina;
	char ponovi;

	do
	{
		system("cls");
		kolekcijaTrgovina.push_back(GetTrgovina());

		cout << "Dodati jos trgovina(d/n): ";
		cin >> ponovi;
	} while (ponovi == 'd');
	
	cout << endl;
	Ispis(kolekcijaTrgovina);
}