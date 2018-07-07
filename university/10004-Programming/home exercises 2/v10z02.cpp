#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Karakteristike
{
	short KonjskeSnage;
	short BrojKubika;
};
struct Automobil
{
	string Marka;
	Karakteristike Performanse;
};
struct Motocikl
{
	string Marka;
	Karakteristike Performanse;
};

void Ispis(Automobil a, Motocikl m)
{
	cout << "AUTOMOBIL" << endl;
	cout << "MARKA: " << a.Marka << endl;
	cout << "SNAGA: " << a.Performanse.KonjskeSnage << endl;
	cout << "BROJ KUBIKA: " << a.Performanse.BrojKubika << endl << endl;

	cout << "MOTOCIKL" << endl;
	cout << "MARKA: " << m.Marka << endl;
	cout << "SNAGA: " << m.Performanse.KonjskeSnage << endl;
	cout << "BROJ KUBIKA: " << m.Performanse.BrojKubika << endl << endl;
}
Automobil GetAutomobil()
{
	Automobil a;
	cout << "Marka automobila: ";
	cin >> a.Marka;
	
	cout << "Snaga: ";
	cin >> a.Performanse.KonjskeSnage;

	cout << "Broj kubika: ";
	cin >> a.Performanse.BrojKubika;
	return a;
}

Motocikl GetMotocikl()
{
	Motocikl m;
	cout << "Marka motocikla: ";
	cin >> m.Marka;
	
	cout << "Snaga: ";
	cin >> m.Performanse.KonjskeSnage;

	cout << "Broj kubika: ";
	cin >> m.Performanse.BrojKubika;
	return m;
}
void main()
{
	Ispis(GetAutomobil(), GetMotocikl());
}