#include <iostream>
using namespace std;

// zadatak 6. Napisite funkciju maksimum koja vraca veci od tri proslijedena broja.

int maksimum(int a, int b, int c) {
	int najveci = 0;
	if (a > najveci) {
		najveci = a;
	}
	if (b > najveci) {
		najveci = b;
	}
	if (c > najveci) {
		najveci = c;
	}
	return najveci;
}

int main() {
	int a, b, c;

	cout << "Unesite broj a: ";
	cin >> a;
	cout << "Unesite broj b: ";
	cin >> b;
	cout << "Unesite broj c: ";
	cin >> c;

	cout << "Najveci broj je: " << maksimum(a, b, c) << endl;

	return 0;
}