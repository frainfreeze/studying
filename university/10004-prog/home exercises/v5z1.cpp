#include <iostream>
#include <vector>
using namespace std;

int main()
{
	vector <int> poljeBrojeva;
	char nastaviUnos;

	do
	{
		int broj;
		cout << "Unesite broj: ";
		cin >> broj;
		poljeBrojeva.push_back(broj);

		cout << "Nastavi unos (d/n): ";
		cin >> nastaviUnos;
	} while (nastaviUnos == 'd');


	//Ispis unesenih brojeva
	cout << endl << "Ispis brojeva: ";
	for (int i = 0; i < poljeBrojeva.size(); i++)
	{
		if(i != poljeBrojeva.size()-1)
			cout << poljeBrojeva[i] << ", ";
		else
			cout << poljeBrojeva[i] << ".";
	}
	cout << endl << endl;
	return 0;
}