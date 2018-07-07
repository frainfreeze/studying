#include <iostream>
#include <vector>

using namespace std;

/*
Zadatak 5. Napisite program koji od korisnika ucitava 10 brojeva u polje.
Stvorite novo polje samo od parnih brojeva iz prvog polja.
Ispisite elemente polja odvojene zarezom.
*/

int main() {

	int polje[10];
	vector<int> parni;

	//stvorimo polje brojeva
	for (int i = 0; i < 10; i++)
	{
		cout << "Unesite broj: ";
		cin >> polje[i];
	}

	//stvorimo polje parnih brojeva
	for (int i = 0; i < 10; i++)
	{
		if (i % 2 == 0) {
			parni.push_back(i);
		}
	}

	//ispisimo polje
	for (int i = 0; i < size(parni); i++)
	{
		if (i != size(parni)-1)
		{
			cout << parni[i] << ", ";
		}
		else {
			cout << parni[i] << "." << endl;;
		}
	}
	
	return 0;
}
