#include <iostream>
using namespace std;

int maksimum(int a, int b, int c)
{
	if(a > b && a > c)
		return a;	
	else if(b > a && b > c)
		return b;
	else
		return c;
}

int main(){

	int broj1,broj2,broj3;
	cout << "Unesite 1. broj: ";
	cin >> broj1;
	cout << "Unesite 2. broj: ";
	cin >> broj2;
	cout << "Unesite 3. broj: ";
	cin >> broj3;

	int veci = maksimum(broj1, broj2, broj3);
	cout << "Najveæi od 3 unesena je: " << veci;

	cout << endl;
	return 0;
}