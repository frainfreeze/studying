#include <iostream>
#include <string>
using namespace std;

bool JeProst(int n)
{
	for (int i = 2; i <= n / 2; i++) {
		if (n % i == 0)
			return false;
	}
	return true;
}

void Ispis(int a, int b) {
	if (a > b)
		return;

	if (JeProst(a))
		cout << a << " ";

	Ispis(a + 1, b);
}

void main()
{
	int a, b;
	cout << "Ispis prostih brojeva iz zadanog raspona" << endl;
	cout << "Unesite 1. broj: ";
	cin >> a;
	cout << "Unesite 2. broj: ";
	cin >> b;

	Ispis(a, b);

	cout << endl;

	char ponovi;
	cout << "Ponoviti (d/n): ";
	cin >> ponovi;
	if (ponovi == 'd')
		main();
}