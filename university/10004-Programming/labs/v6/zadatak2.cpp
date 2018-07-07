#include <iostream>
using namespace std;

// Zadatak 2. Napisite funkciju koja ispisuje sve brojeve od 1 do zadanog broja

void IspisDoBroja(int broj) {
	for (int i = 1; i <= broj; i++)
	{
		if (i == broj) {
			cout << i << "." << endl;
		}
		else {
			cout << i << ", ";
		}
	}
}

int main() {

	int broj;

	cout << "Unesite broj: ";
	cin >> broj;
	IspisDoBroja(broj);

	return 0;
}
