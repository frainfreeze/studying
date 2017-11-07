#include <iostream>
using namespace std;

// Zadatak 3. Napisite funkciju koja kao parametar prima dva cijela broja, te ispisuje sve brojeve od manjeg do veceg.

void IspisOdManjegDoVeceg(int a, int b) {
	while (a <= b) {
		if (a == b) {
			cout << a << "." << endl;
			break;
		} else {
		cout << a << ", ";
		a++;
		}
	}
}

int main() {
	
	int a, b;
	
	cout << "Unesite broj a: ";
	cin >> a;
	cout << "Unesite broj b: ";
	cin >> b;

	IspisOdManjegDoVeceg(a, b);

	return 0;
}
