#include <iostream>
#include <cmath>
using namespace std;

#define PI 3.14159

int main()
{
	float radijus;

	cout << "O i P kruga" << endl;
	cout << "Unesite radijus kruga: ";
	cin >> radijus;

	float povrsina = pow(radijus, 2) * PI;
	float opseg = 2 * radijus * PI;

	cout << "Povrsina kruga: " << povrsina << endl;
	cout << "Opseg kruga: " << opseg << endl;
	return 0;
}