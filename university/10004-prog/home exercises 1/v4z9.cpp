#include <iostream>
#include <ctime>
using namespace std;


int main()
{		
	srand(time(0));	
	int polje[20];
	for (int i = 0; i < 20; i++)
	{
		polje[i] = rand() % 100;
	}

	cout << "Ispis polja: ";
	for (int i = 0; i < 20; i++)
	{
		cout << polje[i] << " ";
	}
			
	float suma = 0;
	int umnozak = 1;

	for (int i = 0; i < 20; i++)
	{
		suma += polje[i];
		umnozak *= polje[i];
	}

	cout << endl << "Suma elemenata polja je: " << suma;
	cout << endl << "Umnozak elemenata polja je: " << umnozak;
	cout << endl << "Aritmeticka sredina polja je: " << suma/20.0;

	cout << endl;
	return 0;
}
