#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main()
{
	vector <int> poljeBrojeva;
	vector <int> parniBrojevi;
	vector <int> neparniBrojevi;

	int brojBrojeva;
	cout << "Koliko brojeva cete unijeti: ";
	cin >> brojBrojeva;

	//Unos brojeva
	for (int i = 0; i < brojBrojeva; i++)
	{
		cout << "Unesite " << i+1 << ". broj: ";
		int broj;
		cin >> broj;
		poljeBrojeva.push_back(broj);
	}

	//Izdvoji parne i neprane brojeve
	for (int i = 0; i < poljeBrojeva.size(); i++)
	{
		if(poljeBrojeva[i] % 2 == 0)
			parniBrojevi.push_back(poljeBrojeva[i]);
		else
			neparniBrojevi.push_back(poljeBrojeva[i]);
	}

	//Ispis parnih brojeva
	cout << "\nParni brojevi: ";	
	for (int i = 0; i < parniBrojevi.size(); i++)
	{
		if(i != parniBrojevi.size() - 1)
			cout << parniBrojevi[i] << ", ";
		else
			cout << parniBrojevi[i] << ".";
	}

	//Neparni brojevi
	cout << "\nNeparni brojevi: ";
	for (int i = neparniBrojevi.size()-1; i >= 0; i--)
	{
		if(i != 0)
			cout << neparniBrojevi[i] << ", ";
		else
			cout << neparniBrojevi[i] << ".";
	}


	cout << endl << endl;
	return 0;
}