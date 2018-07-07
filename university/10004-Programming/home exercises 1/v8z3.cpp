#include <iostream>
#include <ctime> 
#include <string>
using namespace std;

void main() {

	int visinaTrokuta;
	cout << "Upisite visinu trokuta: ";
	cin >> visinaTrokuta;

	for (int i = 1; i <= visinaTrokuta; i++) 
	{

		// Prvo nam dolazi visinaTrokuta - i razmaka.
		for (int j = 0; j < visinaTrokuta - i; j++) {
			cout << " ";
		}

		// Zatim nam dolazi (i - 1) zvjezdica s lijeve strane.
		for (int j = 0; j < i - 1; j++) {
			cout << "*";
		}

		// Zatim nam dolazi jedna srednja zvjezdica.
		cout << "*";

		// Zatim nam dolazi (i - 1) zvjezdica s desne strane.
		for (int j = 0; j < i - 1; j++) {
			cout << "*";
		}

		cout << endl;
	}

}