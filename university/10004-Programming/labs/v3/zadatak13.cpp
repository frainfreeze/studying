#include <iostream>
using namespace std;

// Zadatak 13 program koji s tipkovnice ucitava dva cijela broja i operaciju. Ispravne operacije su +,-, *,/. Ispisite rezultat
int main()
{
	int broj1, broj2;
	char oper;

	cout << "Unesite broj: ";
	cin >> broj1;

	cout << "Unesite drugi broj: ";
	cin >> broj2;

	cout << "Unesite operaciju (+, -, *, /) ";
	cin >> oper;


	switch (oper)	
	{
	case '+' :
		cout << broj1 + broj2;
		break;

	case '-' :
		cout << broj1 - broj2;
		break;

	case '*' :
		cout << broj1 * broj2;
		break;

	case '/' :
		cout << broj1 / broj2;
		break;

	default:
		break;
	}

	cout << endl;
	return 0;
}