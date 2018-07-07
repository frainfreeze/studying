#include <iostream>
using namespace std;
// Zadatak 1. Napisite funkciju koja vraca kvadrat proslijedenog joj cijelog broja.

int kvadrat(int broj) {
	return broj*broj;
}

int main() {

	cout << "2^2: " << kvadrat(2) << endl;
	return 0;
}