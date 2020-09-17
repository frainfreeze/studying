#include <iostream>
using namespace std;

// Zadatak 12 program ucita dva broja i ispise sve proste brojeve izmedu njih
int main()
{
	int broj1, broj2;
	bool prostBroj = true;

	cout << "unesite prvi broj: ";
	cin >> broj1;

	cout << "\nunesite drugi broj: ";
	cin >> broj2;

	for (int brojac=broj1; brojac <= broj2; brojac++)
	{

		for (int i = 2; i < brojac; i++)
		{
			if (brojac % i == 0)
			{
				prostBroj = false;
				break;
			}
			else
			{
				prostBroj = true;
			}
		}

		if (prostBroj == true)
		{
			cout << brojac << "  ";
		} 
		
	}

	cout << endl;
	return 0;
}