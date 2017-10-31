#include <iostream>
#include <vector>

using namespace std;

/*
Zadatak 2. Napisite program koji ce stvoriti polje sa svim brojevima 
izmedu 10 i 100 koju su djeljivi sa 3. Ispisite to polje u obrnutom 
redoslijedu i izracunajte sumu brojeva u polju.
*/

int main(){

	int suma = 0, brojac = 10;
	vector<int> brojevi;

	while (brojac <= 100)
	{
		if (brojac % 3 == 0) {
			brojevi.push_back(brojac);
		}
		brojac++;
	}

	//ispis u obrnutom redosljedu
	for (int i = size(brojevi) - 1; i >= 0; i--)
	{
		if (i != 0) {
			cout << brojevi[i] << ", ";
		}
		else {
			cout << brojevi[i] << ".";
		}
	}

	cout << endl;

	//suma
	for (int i = 0; i < size(brojevi); i++)
	{
		suma = suma + brojevi[i];
	}

	cout << "suma brojeva je: " << suma << endl;
	return 0;
}