#include <iostream>
using namespace std;

int GetBrojParnihBrojevauPolju(int* polje, int velicinaPolja)
{
	int brojParnih = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (polje[i] % 2 == 0)
			brojParnih++;
	}
	return brojParnih;
}

void IspisParnihBrojeva(int* poljeParnihBrojeva, int velicinaPolja)
{
	system("cls");
	cout << "ISPIS PARNIH BROJEVA" << endl << endl;
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << poljeParnihBrojeva[i] << endl;
	}
	delete[] poljeParnihBrojeva;
}

void KreirajPoljeParnihBrojeva(int* polje, int velicinaPolja)
{
	int brojPranihBrojeva = GetBrojParnihBrojevauPolju(polje, velicinaPolja);
	int* poljeParnih = new int[brojPranihBrojeva];
	int index = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (polje[i] % 2 == 0){
			poljeParnih[index] = polje[i];
			index++;
		}
	}
	IspisParnihBrojeva(poljeParnih, brojPranihBrojeva);
}



void main()
{
	int poljeBrojeva[10] = {1,2,3,4,5,6,7,8,9,10};
	KreirajPoljeParnihBrojeva(poljeBrojeva, 10);
	cout << endl;
}