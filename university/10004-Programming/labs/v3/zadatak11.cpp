#include <iostream>
using namespace std;

// zadatak 11. provjeri dali je broj prost

int main()
{
	int broj, brojac = 0;

	cout << "unesite broj: ";
	cin >> broj;

	for (int i = 2; i< broj; i++)
	{
		if (broj % i == 0)
		{
			brojac++;
			break;
		}
	}
	if (brojac == 0)
	{
		cout << "Prosti broj.";
	}
	else
	{
		cout << "Nije prosti broj.";
	}
	cout << endl;
	return 0;
}