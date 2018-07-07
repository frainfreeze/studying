#include <iostream>
using namespace std;

// Zadatak 8. Napisite funkciju koja ispisuje tablicu mnozenja od 1 do zadanog broja.

int tablicaMnozenja(int x) {

	// vertikalni smjer
	for (int i = 1; i <= x; i++) {
		// horizontalni
		for (int j = 1; j <= x; j++) {
			cout << i*j << "\t";
		}
		cout << endl;
	}
	cout << endl;
	return 0;
}

int main() {

	int x;
	cout << "Unesite broj do kojeg zelite napraviti tablicu mnozenja: ";
	cin >> x;
	tablicaMnozenja(x);

	return 0;
}
