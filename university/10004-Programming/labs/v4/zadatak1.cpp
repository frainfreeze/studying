#include <iostream>
using namespace std;

int main() {

	int brojevi[10] = { 0,1,2,3,4,5,6,7,8,9 };

	cout << "sizeof(brojevi) je " << sizeof(brojevi) << " sizeof(brojevi[0]) je " << sizeof(brojevi[0]) << endl;

	for (int i = 0; i < (sizeof(brojevi) / sizeof(brojevi[0])); i++) {
		cout << brojevi[i] << " ";
	}

	cout << endl;

	return 0;
}
