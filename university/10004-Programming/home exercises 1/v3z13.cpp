#include <iostream>
using namespace std;

int main() {
	int a, b, rezultat;
	char racunskaOperacija;
	bool ispravnoUnesenaRacunskaOperacija = true;

	cout << "Unesite 1.broj: ";
	cin >> a;

	cout << "Unesite 2.broj: ";
	cin >> b;

	cout << "Racunska operacija (+,-,*,/): ";
	cin >> racunskaOperacija;

	switch (racunskaOperacija)
	{
	case '+':
		rezultat = a + b;
		break;
	case '-':
		rezultat = a - b;
		break;
	case '*':
		rezultat = a*b;
		break;
	case '/':
		rezultat = a / b;
		break;
	default:
		cout << "neispravno unesena racunska operacija!\n";
		ispravnoUnesenaRacunskaOperacija = false;
		break;
	}

	if (ispravnoUnesenaRacunskaOperacija)
		cout << a << racunskaOperacija << b << "=" << rezultat << endl;
	return 0;
}