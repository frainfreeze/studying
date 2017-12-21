#include <iostream>
#include <ctime>
using namespace std;


int main()
{
	/*
		Probaj definirati seed unutar for petlje, 
		na taj naèin æeš dobiti 20 istih brojeva
	*/
	srand(time(0));	
	int polje[20];

	for (int i = 0; i < 20; i++)
	{
		/*
			rand() - returns a pseudo-random integral number in the range between 0 and RAND_MAX
		*/
		polje[i] = rand() % 100;
	}

	cout << "Ispis polja: ";
	for (int i = 0; i < 20; i++)
	{
		cout << polje[i] << " ";
	}
			
	int najmanji = polje[0];
	int najveci = polje[0];

	for (int i = 1; i< 20; i++)
	{
		if(polje[i] > najveci){
			najveci = polje[i];
		}
		if(polje[i] < najmanji){
			najmanji = polje[i];
		}
	}

	cout << endl << "Najveci broj u polju je: " << najveci;
	cout << endl << "Najmanji broj u polju je: " << najmanji;

	cout << endl;
	return 0;
}
