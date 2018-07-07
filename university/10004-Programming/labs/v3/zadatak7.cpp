#include <iostream>
using namespace std;
//Napisite program koji ispisuje ASCII tablicu od 32 do 128.

//todo- ispisati u vise redova
int main() {

	cout << "+---------------+" << endl;

	for (int j = 32; j <= 128; j++) {
		cout << "| " << j << " = " << char(j) << "\t" << "|" << endl; // ispisi kao char
	}

	cout << "+---------------+" << endl;

	return 0;
}