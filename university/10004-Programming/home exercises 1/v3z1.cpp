#include <iostream>
using namespace std;

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	if (broj % 2 == 0)
		cout << "Unijeli ste PARAN broj!" << endl;
	else
		cout << "Unijeli ste NEPARAN broj!" << endl;


	return 0;
}