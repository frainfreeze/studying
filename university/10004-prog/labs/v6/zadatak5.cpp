#include <iostream>
using namespace std;

// zadatak 5. Napisite funkciju minimum koja vraca manji od dva proslijedena broja.

int usporedi(int a, int b) {
	if (a < b) {
		return a;
	}
	else if (b < a) {
		return b;
	}
	else {
		cout << "error! brojevi su isti! ";
	}
}


int main() {

	int a, b;

	cout << "Unesite broj a: ";
	cin >> a;
	cout << "Unesite broj b: ";
	cin >> b;

	cout << "od unesenih brojeva " << a << " i " << b << " manji je " << usporedi(a, b) << endl;

	return 0;
}