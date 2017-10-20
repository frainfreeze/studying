#include <iostream>
using namespace std;

/*
Napisite program koji s tipkovnice ucitava 1 broj i ispisuje koliko on ima
znamenki.


"Given any positive whole number, 
the number of digits are the number of times you can divide 
by ten before the number becomes zero."

1234 --> 123 --> 12 --> 1 --> 0
1 2 3 4

*/

int main() {

	int broj;
	int brojac = 0;

	cout << "unesite broj: ";
	cin >> broj;

	while (broj != 0) {
		broj = broj / 10;
		brojac++;
	}
	
	cout << "Uneseni broj ima " << brojac << " znamenki." << endl;

	return 0;
}