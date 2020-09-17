#include <iostream>
#include <string>
using namespace std;

void main()
{
	int brojBrojeva;

	cout << "Koliko brojeva cete ucitati: ";
	cin >> brojBrojeva;

	int* poljeBrojeva = new int[brojBrojeva];

	for (int i = 0; i < brojBrojeva; i++) {
		cout << (i+1) << ".broj: ";
		cin >> poljeBrojeva[i];
	}

	bool rastuci = true;
	for (int i = 0; i < brojBrojeva - 1; i++) {
		if (poljeBrojeva[i] > poljeBrojeva[i + 1]) {
			rastuci = false;
			break;
		}
	}

	if (rastuci) 
		cout << "Uneseni brojevi su rastuci." << endl;
	else 
		cout << "Uneseni brojevi nisu rastuci." << endl;

	delete[] poljeBrojeva;
	cout << endl;
}