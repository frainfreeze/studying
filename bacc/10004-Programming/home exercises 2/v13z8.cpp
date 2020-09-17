#include <iostream>
#include <string>
using namespace std;

int main() {

	int koliko;

	cout << "Koliko slova zelite ucitati: ";
	cin >> koliko;

	char* slova = new char[koliko];

	for (int i = 0; i < koliko; i++) {

		bool ok;
		do {
			cout << "Slovo: ";
			cin >> slova[i];

			if (slova[i] != 'a' && slova[i] != 'b' && slova[i] != 'c') {
				cout << "Morate unijeti a, b ili c" << endl;
				ok = false;
			}
			else {
				ok = true;
			}
		} while (ok == false);
	}

	int a = 0;
	int b = 0;
	int c = 0;

	for (int i = 0; i < koliko; i++) {
		if (slova[i] == 'a') {
			a++;
		}
		else if (slova[i] == 'b') {
			b++;
		}
		else if (slova[i] == 'c') {
			c++;
		}
	}

	delete[] slova;

	cout << "Slovo a: " << a << endl;
	cout << "Slovo b: " << b << endl;
	cout << "Slovo c: " << c << endl;

	return 0;
}