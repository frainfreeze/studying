#include <iostream>
using namespace std;

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	for (int i = broj; i < (16*broj); i++)
	{
		cout << i << endl;
	}

	return 0;
}