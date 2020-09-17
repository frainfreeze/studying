#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main()
{
	int poljeBrojeva[10];
	vector <int> parniBrojevi;

	//Unos brojeva u polje
	for (int i = 0; i < 10; i++)
	{
		cout << "Unesite broj: ";
		cin >> poljeBrojeva[i];
	}

	//Izdvajanje parnih brojeva iz polja poljeBrojeva
	for (int i = 0; i < 10; i++)
	{
		if(poljeBrojeva[i] % 2 == 0)
			parniBrojevi.push_back(poljeBrojeva[i]);
	}

	cout << "Ispis parnih brojeva: ";
	for (int i = 0; i < parniBrojevi.size(); i++)
	{
		if(i != parniBrojevi.size() - 1)
			cout << parniBrojevi[i] << ", ";
		else
			cout << parniBrojevi[i] << ".";
	}

	cout << endl << endl;

	return 0;
}