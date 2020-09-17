#include <iostream>
#include <string>
using namespace std;

int SumaParnih(int a, int b){
	int suma=0;
	for (int i = a; i <= b; i++) {
		if (i % 2 == 0) {
			suma += i;
		}
	}
	return suma;
}

int SumaNeparnih(int a, int b){
	int suma=0;
	for (int i = a; i <= b; i++) {
		if (i % 2 != 0) {
			suma += i;
		}
	}
	return suma;
}


int main()
{
	int brojA;
	int brojB;

	cout << "Unesite 1. broj: ";
	cin >> brojA;

	cout << "Unesite 2. broj: ";
	cin >> brojB;

	if (brojA > brojB) {
		swap(brojA, brojB);
	}

	cout << endl << "Suma parnih: " << SumaParnih(brojA, brojB);
	cout << endl << "Suma neparnih: " << SumaNeparnih(brojA, brojB);
	
	cout << endl;
	return 0;
}