#include <iostream>
using namespace std;


void Unos(int* polje, int velicinaPolja)
{
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << "Unesite " << (i + 1) << ". broj: ";
		cin >> polje[i];
	}
}

void Ispis(int* polje, int velkicinaPolja)
{
	system("cls");
	cout << "ISPIS BROJEVA" << endl << endl;
	for (int i = 0; i < velkicinaPolja; i++)
	{
		cout << polje[i] << endl;
	}
	/* nakon upotrebe oslobaðam dinamièki alociranu memoriju */
	delete[] polje;
	cout << endl;
}

void main()
{
	int velicinaPolja;
	cout << "Koliko brojeva cete unijeti: ";
	cin >> velicinaPolja;

	/* dinamièki alociram memoriju */
	int* poljeBrojeva = new int[velicinaPolja];

	Unos(poljeBrojeva, velicinaPolja);
	Ispis(poljeBrojeva, velicinaPolja);
}