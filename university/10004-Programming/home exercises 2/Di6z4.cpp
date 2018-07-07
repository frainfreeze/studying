#include <iostream>
using namespace std;

int main() {

	double brojevi[3];

	for (int i = 0; i<3; i++) {
		cout << "Unesite " << i + 1 << ". broj: ";
		cin >> brojevi[i];
	}

	for (int i = 2; i >= 0; i--) {
		cout << brojevi[i] << " ";
	}

	cout << endl;

	int i = 0;
	for (double* poc = brojevi; poc <= brojevi + 2; poc++) {
		cout << "Unesite " << i + 1 << ". broj: ";
		cin >> *poc;
		i++;
	}

	for (double* kraj = brojevi + 2; kraj >= brojevi; kraj--) {
		cout << *kraj << " ";
	}

	cout << endl;
	return 0;
} 
