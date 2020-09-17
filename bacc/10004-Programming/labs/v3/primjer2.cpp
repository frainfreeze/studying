#include <iostream>
using namespace std;

int main() {

	int broj;
	int brojac = 1;

	cout << "Unesite broj: " << endl;
	cin >> broj;

	cout << "\nIspis brojeva od 1 do " << broj << endl;
	
	while (brojac <= broj) {
		if (brojac < broj){
			cout << brojac++ << ", ";
		}
		else {
			cout << brojac++ << "." << endl;
		}
	}

	cout << endl;
	return 0;
}
