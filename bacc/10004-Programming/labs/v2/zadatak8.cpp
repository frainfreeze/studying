#include <iostream>
#include <string>
using namespace std;

int main() {
	
	int ax, ay, az, bx, by, bz;

	cout << "ax: ";
	cin >> ax;

	cout << "ay: ";
	cin >> ay;

	cout << "az: ";
	cin >> az;

	cout << "bx: ";
	cin >> bx;

	cout << "by: ";
	cin >> by;

	cout << "bz: ";
	cin >> bz;

	int skalarni_produkt = ax * bx + ay * by + az * bz;

	cout << "Skalarni produkt je: " << skalarni_produkt << endl;

	return 0;
}