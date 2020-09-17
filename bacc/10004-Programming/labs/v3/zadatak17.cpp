#include <iostream>
using namespace std;

// Zadatak 17 Potrebno je ispisati sve troznamenkaste brojeve ciji je zbroj znamenaka 5, a zadnja im je znamenka 0.(znamenka jedinice)
int main()
{
	int brojac, j, d, s, zbroj;
	cout << "Troznamenkasti brojevi ciji je zbroj znamenaka 5, a zadnja im je znamenka 0 su:" << endl;

	for (brojac = 100; brojac <= 999; brojac++)
	{
		j = brojac % 10;
		d = (brojac / 10) % 10;
		s = brojac / 100;
		cout << " j: " << j << " d: " << d << " s: " << s;
		zbroj = j + d + s;
		cout << " zbroj: " << zbroj << endl;
		if (zbroj == 5 && j == 0)
			cout << brojac << "\n";
	}

	cout << endl;
	return 0;
}