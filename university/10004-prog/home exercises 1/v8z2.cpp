#include <iostream>
using namespace std;

void main() {
	double a, b;
	char racOperacija;
	double rezultat = 0;

	cout << "Unesite broj A: ";
	cin >> a;

	cout << "Unesite broj B: ";
	cin >> b;
	
	bool ponovi;
	do
	{
		ponovi = false;
		cout << endl;
		cout << "Racunaska operacija: ";
		cin >> racOperacija;
		
		if (racOperacija != '+' && racOperacija != '-' && racOperacija != '*' && racOperacija != '/') {
			ponovi = true;
			cout << "Kriva racunska operacija." << endl;
		}
	} while (ponovi);

	switch (racOperacija)
	{
		case '+':
			rezultat = a + b;
			break;
		case '-':
			rezultat = a - b;
			break;
		case '*':
			rezultat = a * b;
			break;
		case '/':
			rezultat = a / b;
			break;
	}

	cout << endl;
	cout << a << racOperacija << b << "=" << rezultat << endl;
}