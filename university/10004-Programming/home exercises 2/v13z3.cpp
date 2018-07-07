#include <iostream>
using namespace std;

bool JedinstvenBrojuPolju(int* polje, int velicinaPolja, int brojKojiSeProvjerava, int indexBrojaKojiSeProvjerava)
{
	bool jedinstvenBroj = true;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (indexBrojaKojiSeProvjerava == i) continue;
		if (polje[i] == brojKojiSeProvjerava)
		{
			jedinstvenBroj = false;
			break;
		}
	}
	return jedinstvenBroj;
}

int BrojRazlicitihElemenatauPolju(int* polje, int velicinaPolja)
{
	int brojRazlicitihBrojeva = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (JedinstvenBrojuPolju(polje, velicinaPolja, polje[i], i))
			brojRazlicitihBrojeva++;
	}
	return brojRazlicitihBrojeva;
}
void IspisRazlicitihBrojeva(int* polje, int velicinaPolja)
{
	system("cls");
	cout << "ISPIS RAZLICITIH BROJEVA POLJA" << endl;
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << polje[i] << endl;
	}
	delete[] polje;
}
void KreirajPoljeRazlicitihElemenata(int* polje, int velicinaPolja)
{
	int brojRazlicitihElemenataPolja = BrojRazlicitihElemenatauPolju(polje, velicinaPolja);
	int* poljeRazlicitihBrojeva = new int[brojRazlicitihElemenataPolja];
	int index = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (JedinstvenBrojuPolju(polje, velicinaPolja, polje[i], i))
		{
			poljeRazlicitihBrojeva[index] = polje[i];
			index++;
		}
	}
	IspisRazlicitihBrojeva(poljeRazlicitihBrojeva, brojRazlicitihElemenataPolja);
}

void main()
{
	int poljeBrojeva[10] = {1,2,3,4,5,6,5,5,9,1};
	KreirajPoljeRazlicitihElemenata(poljeBrojeva, 10);
}