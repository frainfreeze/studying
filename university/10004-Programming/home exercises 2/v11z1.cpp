#include <iostream>
#include <vector>
#include <string>
using namespace std;

void main()
{
	double broj1, broj2;

	double* pBroj1 = &broj1;
	double* pBroj2 = &broj2;

	*pBroj1 = 10.5;
	*pBroj2 = 20.5;

	cout << "BROJ1" << endl;
	cout << "Memorijska adresa: " << pBroj1 << endl;
	cout << "Vrijednost preko pokazivaca: " << *pBroj1 << endl;
	cout << "Vrijednost preko varijable: " << broj1 << endl << endl;

	cout << "BROJ2" << endl;
	cout << "Memorijska adresa: " << pBroj2 << endl;
	cout << "Vrijednost preko pokazivaca: " << *pBroj2 << endl;
	cout << "Vrijednost preko varijable: " << broj2 << endl;


}