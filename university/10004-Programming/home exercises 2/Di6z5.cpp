#include <iostream>
using namespace std;

void ispis(int* polje, int n) {
	for (int i = 0; i<n; i++) {
		cout << polje[i] << " ";
	}
	cout << endl;
}

void ispis_pointeri(int* polje, int n) {
	for (int *poc = polje; poc < polje + n; poc++) {
		cout << *poc << " ";
	}
	cout << endl;
}


int main() {

	int brojevi[5] = { 10,20,30,40,50 };

	ispis(brojevi, 5);
	ispis_pointeri(brojevi, 5);

	return 0;
}