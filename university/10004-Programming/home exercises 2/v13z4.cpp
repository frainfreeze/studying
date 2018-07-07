#include <iostream>
using namespace std;

bool BrojJeProst(int broj)
{
	bool brojJeProst = true;
	for (int i = 2; i < broj; i++)
	{
		if (broj % i == 0)
		{
			brojJeProst = false;
			break;
		}
	}
	return brojJeProst;
}

int GetBrojProstihBrojevauRasponu(int broj)
{
	int brojProstihBrojevauRasponu = 0;
	for (int i = 2; i < broj; i++)
	{
		if (BrojJeProst(i))
			brojProstihBrojevauRasponu++;
	}
	return brojProstihBrojevauRasponu;
}

void IspisPolja(int* polje, int velicinaPolja)
{
	system("cls");
	cout << "ISPIS PROSTIH BROJEVA" << endl;
	int suma = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << polje[i] << endl;
		suma += polje[i];
	}
	delete[] polje;
	cout << endl;
	cout << "SUMA PROSTIH BROJEVA: " << suma << endl;
}

void NapuniPoljeProstimBrojevima(int* polje, int gornjaGranicaRaspona)
{
	int index = 0;
	for (int i = 2; i < gornjaGranicaRaspona; i++)
	{
		if (BrojJeProst(i))
		{
			polje[index] = i;
			index++;
		}
	}
}

void main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	int velicinaPolja = GetBrojProstihBrojevauRasponu(broj);
	int* poljeProstihBrojeva = new int[velicinaPolja];
	NapuniPoljeProstimBrojevima(poljeProstihBrojeva, broj);

	IspisPolja(poljeProstihBrojeva, velicinaPolja);
}