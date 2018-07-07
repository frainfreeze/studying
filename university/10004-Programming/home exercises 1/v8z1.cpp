#include <iostream>
using namespace std;

void main() {
	int ocjena = 0;

	do
	{
		cout << "Unesite ocjenu: ";
		cin >> ocjena;

		if (ocjena < 1 || ocjena > 5)
			cout << "Krivo unesena ocjena!";
		cout << endl;
	} while (ocjena < 1 || ocjena > 5);


	switch (ocjena)
	{
	case 1:
		cout << "Nedovoljan" << endl;
		break;
	case 2:
		cout << "Dovoljan" << endl;
		break;
	case 3:
		cout << "Dobar" << endl;
		break;
	case 4:
		cout << "Vrlo dobar" << endl;
		break;
	case 5:
		cout << "Izvrstan" << endl;
		break;
	default:
		break;
	}
	cout << endl;
}