#include <iostream>
using namespace std;

int Kvadrat(int a){
	return a*a;
}

int main(){

	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	int kvadratBroja = Kvadrat(broj);
	cout << "Kvadrat ucitanog broja: " << kvadratBroja;

	cout << endl;
	return 0;
}