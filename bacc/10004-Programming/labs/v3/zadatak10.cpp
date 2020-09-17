#include <iostream>
using namespace std;

/*
Napisite program koji s tipkovnice ucitava dva cijela
broja A i B, te ispisuje pravokutnik sastavljen od znaka * 
koji je sirine A i visine B.

*/

int main() {

	int A, B;
	cout << "unesite stranicu A: ";
	cin >> A;
	cout << endl << "unesite stranicu B: ";
	cin >> B;

	//gornja stranica kocke
	for (int red = 0; red < A; ++red){
			cout << "*";
	}

	cout << endl;

	// stranice, svaki stupac ima asteriks nakon kojeg dolazi a-2 praznih mjesta i drugi asteriks
	for (int stupac = 0; stupac < B; ++stupac) {
		
		// lijeva stranica
		cout << "*";

		// razmaci
		for (int razm = 0; razm < (A-2); ++razm) {
			cout << " ";
		}

		// desna stranica i newline
		cout << "*\n";
		}


	//doljnja stranica
	for (int red = 0; red < A; ++red) {
		cout << "*";
	}

	cout << endl;
	return 0;
}
