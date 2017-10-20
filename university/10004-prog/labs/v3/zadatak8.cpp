#include <iostream>
using namespace std;

/*
Napisite program koji s tipkovnice ucitava dva cijela 
broja te ispisuje sve brojeve od veceg prema manjem.
*/

int main() {

	int broj, broj1;

	cout << "unesite cijeli broj: ";
	cin >> broj;
	cout << endl << "unesite drugi cjeli broj: ";
	cin >> broj1;

	int a = broj;
	int b = broj1;

	for (; a >= b; a--) {
		cout << a << endl;
	}
	return 0;
}