#include <iostream>
using namespace std;

int main() {

	int brojA;
	int brojB;

	do {
		cout << "Unesite prvi broj: ";
		cin >> brojA;
		cout << "Unesite drugi broj: ";
		cin >> brojB;

		for (int i = brojA; i >= brojB; i--)
		{
			cout << i << " ";
		}
		cout << endl;
	} while (brojA > brojB);

	cout << endl;
	return 0;
}