#include <iostream>
using namespace std;

int main()
{
	int stranicaA, stranicaB;
	cout << "IZRACUNAVANJE POVRSINE PRAVOKUTNIKA" << endl;
	
	cout << "Unesite duljinu stranice A: ";
	cin >> stranicaA;
	cout << "Unesite duljinu stranice B: ";
	cin >> stranicaB;

	int povrsina = stranicaA * stranicaB;
	int opseg = 2 * (stranicaA + stranicaB);

	cout << "Povrsina: " << povrsina << endl;
	cout << "Opseg: " << opseg << endl;

	return 0;
}