#include <iostream>
using namespace std;

int suma(int polje[], int n) {
	int suma = 0;
	for (int i = 0; i < n; i++){
		if (polje[i] % 3 == 0) suma += polje[i];
	}
	return suma;
}

int main() {
	int polje[5] = { 5,6,15,3,4 };
	cout << "Suma brojeva u polju djeljivih sa 3 je: " << suma(polje, 5) << endl;
	return 0;
}