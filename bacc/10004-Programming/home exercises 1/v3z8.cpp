#include <iostream>
using namespace std;

int main() {

	int veci, manji;

	cout << "Unesite broj A: ";
	cin >> veci;

	cout << "Unesite broj B: ";
	cin >> manji;

	if (veci >= manji) {
		for (int i = manji; i <= veci; i++) {
			cout << i << endl;
		}
	}
	else
	{
		for (int i = veci; i <= manji; i++) {
			cout << i << endl;
		}
	}

	return 0;
}