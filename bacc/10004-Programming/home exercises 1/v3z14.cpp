#include <iostream>
using namespace std;

int main() {
	int rb;
	cout << "Unesite redni broj dana: ";
	cin >> rb;

	switch (rb) {
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