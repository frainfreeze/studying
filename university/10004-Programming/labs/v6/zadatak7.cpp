#include <iostream>
using namespace std;

// zadatak 7. Napisite funkciju paran koja vraca istinu ukoliko je proslijedeni broj paran.

bool jeliParan(int broj) {
	if (broj % 2 == 0) {
		return true;
	}
	else {
		return false;
	}
}

int main() {
	int broj;
	cout << "Unesite broj: " << endl;
	cin >> broj;

	cout << "unsesni broj je: ";
	if (jeliParan(broj)) { 
		cout << "paran" << endl; }
	else { 
		cout << "ne paran" << endl;
	}
	return 0;
}