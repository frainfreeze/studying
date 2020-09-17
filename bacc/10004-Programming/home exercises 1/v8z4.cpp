#include <iostream>
#include <ctime> 
#include <string>
using namespace std;

void main() {

	int poljeBrojeva[5];

	for (int i = 0; i < 5; i++)
	{
		cout << "Unesite " << i + 1 << ". broj: ";
		cin >> poljeBrojeva[i];
	}

	int min = poljeBrojeva[0];
	int max = poljeBrojeva[0];
	
	for (int i = 0; i < 5; i++)
	{
		if (poljeBrojeva[i] < min)
			min = poljeBrojeva[i];

		if (poljeBrojeva[i] > max)
			max = poljeBrojeva[i];
	}

	cout << endl;
	cout << "Min: " << min << endl;
	cout << "Max: " << max << endl;
	cout << endl;
}