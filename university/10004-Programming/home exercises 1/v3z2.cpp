#include <iostream>
using namespace std;

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	if (broj % 3 == 0)
		cout << "Broj je djeljiv s 3!" << endl;
	if (broj % 6 == 0)
		cout << "Broj je djeljiv sa 6!" << endl;
	if (broj % 3 != 0 && broj % 6 != 0)
		cout << "Broj " << broj << " nije djeljiv niti sa 3 niti sa 6." << endl;




	return 0;
}