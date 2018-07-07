#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Proizvod
{
	string Naziv;
	int KolicinaNaSkladistu;
	float Cijena;
};
Proizvod GetProizvod()
{
	Proizvod p;
	cout << "Naziv proizvoda: ";
	getline(cin, p.Naziv);

	cout << "Kolicina na skladistu: ";
	cin >> p.KolicinaNaSkladistu;

	cout << "Cijena: ";
	cin >> p.Cijena;

	return p;
}
void Ispis(Proizvod najjeftiniji, Proizvod najskuplji)
{
	cout << "NAJJEFTINIJI PROIZVOD" << endl;
	cout << "NAZIV:" << najjeftiniji.Naziv << endl;
	cout << "KOLICINA NA SKLADISTU:" << najjeftiniji.KolicinaNaSkladistu << endl;
	cout << "CIJENA:" << najjeftiniji.Cijena << endl << endl;

	cout << "NAJSKUPLJI PROIZVOD" << endl;
	cout << "NAZIV:" << najskuplji.Naziv << endl;
	cout << "KOLICINA NA SKLADISTU:" << najskuplji.KolicinaNaSkladistu << endl;
	cout << "CIJENA:" << najskuplji.Cijena << endl << endl;

}
void main()
{
	vector<Proizvod> kolekcijaProizvoda;
	char ponovi;
	do
	{
		system("cls");
		kolekcijaProizvoda.push_back(GetProizvod());

		cout << "Dodati jos proizvoda (d/n):";
		cin >> ponovi;
		cin.ignore();
	} while (ponovi == 'd');

	system("cls");
	/* Naði najjeftiniji i najskuplji proizvod */
	Proizvod najjeftiniji = kolekcijaProizvoda[0];
	Proizvod najskuplji = kolekcijaProizvoda[0];

	for (int i = 0; i < kolekcijaProizvoda.size(); i++)
	{
		//Provjera najskupljeg
		if(kolekcijaProizvoda[i].Cijena > najskuplji.Cijena)
			najskuplji = kolekcijaProizvoda[i];

		//Provjera najjeftinijeg
		if(kolekcijaProizvoda[i].Cijena < najjeftiniji.Cijena)
			najjeftiniji = kolekcijaProizvoda[i];
	}

	Ispis(najjeftiniji, najskuplji);

}