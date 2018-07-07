#include <iostream>

using namespace std;

int main() {
	int broj = 1;
	int *pbroj = &broj;
	int& rbroj = broj;

	cout << "Broj preko varijable: " << broj << endl;
	cout << "Broj dereferenciranjem pokazivaca: " << *pbroj << endl;
	cout << "Broj preko reference: " << rbroj << endl;
	cout << "Adresa varijable: " << pbroj << endl << endl;

	*pbroj = 2;
	cout << "Nakon promjene preko pointera" << endl;
	cout << "Broj preko varijable: " << broj << endl;
	cout << "Broj dereferenciranjem pokazivaca: " << *pbroj << endl;
	cout << "Broj preko reference: " << rbroj << endl;
	cout << "Adresa varijable: " << pbroj << endl << endl;

	rbroj = 3;
	cout << "Nakon promjene preko reference" << endl;
	cout << "Broj preko varijable: " << broj << endl;
	cout << "Broj dereferenciranjem pokazivaca: " << *pbroj << endl;
	cout << "Broj preko reference: " << rbroj << endl;
	cout << "Adresa varijable: " << pbroj << endl << endl;

	return 0;
}
