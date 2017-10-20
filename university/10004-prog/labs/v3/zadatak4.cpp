#include <iostream>
using namespace std;

//  Napišite program koji ispisuje brojeve od 16 do 42, jedan ispod drugog. Napravite
// ispis pomoæu while i for petlje.
int main() {
	int a = 16;
	int b = 42;

	while ( a <= b) {
		cout << a++ << endl;
	}
	cout << endl;

	for (int a = 16; a <= b; a++) {
		cout << a << endl;
	}

	return 0;
}