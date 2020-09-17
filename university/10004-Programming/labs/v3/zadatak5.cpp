#include <iostream>
using namespace std;

// Napišite program koji ispisuje tablicu množenja od 1 do 10.

int main() {

	// vertikalni smjer
	for (int i = 1; i <= 10; i++) {
		// horizontalni
		for (int j = 1; j <= 10; j++) {
			cout << i*j << "\t";
		}
		cout << endl;
	}
	cout << endl;
	return 0;
}