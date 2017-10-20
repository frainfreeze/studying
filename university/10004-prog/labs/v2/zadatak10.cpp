#include <iostream>
#include <cmath>
using namespace std;

int main()
{
	float PI = 3.14159;
	float radijus;

	cout << "IZRACUNAVANJE OSEGA I POVRSINE KRUGA" << endl;
	cout << "Unesite radijus kruga: ";
	cin >> radijus;

	float povrsina = pow(radijus, 2) * PI;
	float opseg = 2 * radijus * PI;

	cout << "Povrsina kruga: " << povrsina << endl;
	cout << "Opseg kruga: " << opseg << endl;
	return 0;
}