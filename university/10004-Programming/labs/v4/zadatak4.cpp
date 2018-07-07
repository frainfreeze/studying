#include <iostream>
using namespace std;

int main() {

	int brojevi[10];

	for (int i = 0; i < 10; i++)
	{
		cout << "Unesite " << i+1 << ". broj: " << endl;
		cin >> brojevi[i];
	}

	cout << endl;

	for (int i = ((sizeof(brojevi) / sizeof(brojevi[0])) - 1); i >= 0; i--) {
		if (i == 0) {
			cout << "Broj " << i + 1 << ". je: " << brojevi[i] << ".";
			break;
		}

		cout << "Broj " << i + 1 << ". je: " << brojevi[i] << ", " << endl;

	}

	cout << endl;

	return 0;
}
