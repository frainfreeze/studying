#include <iostream>
using namespace std;

int main() {

	int brojevi[10];

	for (int i = 0; i < 10; i++)
	{
		cout << "Unesite broj: " << endl;
		cin >> brojevi[i];
	}

	cout << endl;

	for (int i = ((sizeof(brojevi) / sizeof(brojevi[0])) - 1); i >= 0; i--) {
		if (i == 0) {
			cout << brojevi[i] << ".";
			break;
		}

		cout << brojevi[i] << ", ";

	}

	cout << endl;

	return 0;
}
