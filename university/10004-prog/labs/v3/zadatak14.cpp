#include <iostream>
using namespace std;

// Zadatak 14 Napisite program koji ucitava redni broj dana u tjednu (1-7), te ispisuje puni naziv dana.
int main()
{
	int dan;

	cout << "unesite dan u tjednu brojem od 1 do 7: " << endl;
	cin >> dan;

	switch (dan) {
	case 1:
		cout << "Ponedjeljak";
		break;
	case 2:
		cout << "Utorak";
		break;
	case 3:
		cout << "Srijeda";
		break;
	case 4:
		cout << "Cetvrtak";
		break;
	case 5:
		cout << "Petak";
	case 6:
		cout << "Subota";
		break;
	case 7:
		cout << "Nedjelja";
		break;
	default:
		cout << "Niste unesli ispravan redni broj dana!";
		break;
	}

	cout << endl;
	return 0;
}