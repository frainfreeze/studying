#include <iostream>
#include <vector>
using namespace std;

int main()
{
	int broj;
	vector <int> parniBrojevi;

	//Unos brojeva dok god korinik ne unese broj veci od 100
	do
	{
		cout << "Unesite broj veci od 100: ";
		cin >> broj;
	} while (broj < 100);
	
	//Upisati u polje parne brojeve iz raspona [1-broj]
	for (int i = 1; i <= broj; i++)
	{
		if(i % 2 == 0)
			parniBrojevi.push_back(i);
	}

	//Ispis parnih brojeva
	cout << endl << "Ispis parnih brojeva: " << endl;
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