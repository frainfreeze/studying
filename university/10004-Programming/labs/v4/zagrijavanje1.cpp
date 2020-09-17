#include <iostream>
using namespace std;

int main() {

	int broj1, broj2;

	cout << "Unesite cijeli broj: " << endl;
	cin >> broj1;

	cout << "Unesitie jos jedan cijeli broj: " << endl;
	cin >> broj2;

	if (broj1 + broj2 > 100) {

		cout << "Veliki brojevi" << endl;
	}
	else if (broj1 + broj2 < 10 ){
		cout << "mali brojevi" << endl;
	}
	else if ((broj1 + broj2 > 10) && (broj1 + broj2 < 100)) {
		cout << "taman" << endl;
	}

	return 0;
}