#include <iostream>
#include<ctime>
using namespace std;

/*
Zadatak 9. Za polje generirano u prethodnom zadatku izracunajte sumu elemenata, umnozak elemenata te aritmeticku sredinu polja

*/

int main()
{
	srand(time(0)); //seed
	int polje[20];

	//popunimo polje
	for (int i = 0; i < 20; i++)
	{
		polje[i] = rand() % 100;
	}

	//suma
	float suma = 0, umnozak = 1, aSredina =0;

	for (int i = 1; i< 20; i++)
	{
		cout << polje[i] << "; ";
		suma = suma + polje[i];
		umnozak = umnozak * polje[i];
	}

	aSredina = umnozak / 2;

	cout << "Suma: " << suma << " Umnozak: " << umnozak << " Aritmeticka sredina: " << aSredina << endl;
	return 0;
}