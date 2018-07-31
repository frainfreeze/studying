#include <iostream>
#include "Razlomak.h"

using namespace std;

int main() 
{
	int dalje;
	do {
		int brojnik;
		cout << "Unesite brojnik:";
		cin >> brojnik;
		int nazivnik;
		cout << "Unesite nazivnik:";
		cin >> nazivnik;

		Razlomak r(brojnik, nazivnik);

		int skalar;
		cout << "Unesite skalar:";
		cin >> skalar;

		cout << r.to_string() << " * " << skalar << " = ";
		r.multiply(skalar);
		cout << r.to_string() << endl;

		cout << "Dalje(1/0):";
		cin >> dalje;
	} while (dalje == 1);

	return 0;
}