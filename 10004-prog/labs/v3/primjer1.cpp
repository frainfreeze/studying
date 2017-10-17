#include <iostream>
using namespace std;

int main() {

	int broj;


	while (true) {
		cout << "Unesite broj: " << endl;

		cin >> broj;

		if (broj > 0) {
			cout << "Unijeli ste broj veci od nula." << endl;

		}
		else if (broj < 0) {
			cout << "Broje je manji od nula." << endl;

		}
		else {
			cout << "Broje je nula." << endl;
		}
	}

	return 0;
}