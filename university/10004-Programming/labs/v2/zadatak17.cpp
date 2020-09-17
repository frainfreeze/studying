#include <iostream>
using namespace std;

int main()
{
	int broj = 10;

	//Lijeva znamenka
	int L;
	//Desna znamenka
	int D;

	L = broj / 10;
	D = broj % 10;

	cout << "BROJ: " << broj << endl;
	cout << "Lijeva znamenka: " << L << endl;
	cout << "Desna znamenka: " << D << endl;
	return 0;
}