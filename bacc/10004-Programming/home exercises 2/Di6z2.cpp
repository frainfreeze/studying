#include <iostream>

using namespace std;

void primi_vrijednost(int brojVr) {
	brojVr++;
	cout << "Vrijednost varijable u funkciji primi_vrijednost:" << brojVr << endl;
}

void primi_pokazivac(int *brojPok) {
	//paziti na zagrade prije uvecanja!!
	(*brojPok)++;
	cout << "Vrijednost varijable u funkciji primi_pokazivac:" << *brojPok << endl;
}

void primi_referencu(int &brojRef) {
	brojRef++;
	cout << "Vrijednost varijable u funkciji primi_pokazivac:" << brojRef << endl;
}


int main() {
	int broj = 1;

	cout << "Varijabla prije poziva primi_vrijednost: " << broj << endl;
	primi_vrijednost(broj);
	cout << "Varijabla nakon poziva primi_vrijednost: " << broj << endl << endl;

	cout << "Varijabla prije poziva primi_pokazivac: " << broj << endl;
	primi_pokazivac(&broj);
	cout << "Varijabla nakon poziva primi_pokazivac: " << broj << endl << endl;

	cout << "Varijabla prije poziva primi_referencu: " << broj << endl;
	primi_referencu(broj);
	cout << "Varijabla nakon poziva primi_referencu: " << broj << endl << endl;

	return 0;
}