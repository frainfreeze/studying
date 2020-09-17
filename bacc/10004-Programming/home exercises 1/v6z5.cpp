#include <iostream>
using namespace std;

int minimum(int a, int b)
{
	if(a < b)
		return a;
	else
		return b;
}

int main(){

	int broj1,broj2;
	cout << "Unesite 1. broj: ";
	cin >> broj1;
	cout << "Unesite 2. broj: ";
	cin >> broj2;
		
	int manji = minimum(broj1, broj2);
	cout << "Manji od 2 unesena je: " << manji;

	cout << endl;
	return 0;
}