#include <iostream>
using namespace std;

int main() {

	int ocjena;

	cout << "Unesite ocjenu: " << endl;
	cin >> ocjena;

	switch (ocjena){
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
		cout << "vrlo dobar" << endl;
		break;
	case 5:
		cout << "Odlican" << endl;
		break;
	default:
		cout << "Krivo unesena ocjena." << endl;
		break;
	}

	return 0;
}
