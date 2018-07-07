#include <iostream>
#include <string>
using namespace std;

bool BrojJeProst(int broj);

void main() {
	system("cls");
	int a, b;

	cout << "Unesite donju granicu raspona: ";
	cin >> a;

	do
	{
		cout << "Unesite gornju granicu raspona: ";
		cin >> b;
		if (b < a)
			cout << "Vrijednost gornje granice mora biti veca od donje granice." << endl;
	} while (b < a);

	cout << endl;
	cout << "Prosti brojevi iz raspona " << a << " - " << b << endl;
	cout << "-------------------------------" << endl;
	for (int i = a; i <= b; i++)
	{
		if (BrojJeProst(i))
			cout << i << " ";
	}
	cout << endl;

	char ponoviti;
	cout << "Ponoviti (d/n): ";
	cin >> ponoviti;

	if (ponoviti == 'd')
		main();
}

bool BrojJeProst(int broj) {
	bool jeProst = true;
	for (int i = 2; i < broj; i++)
	{
		if (broj % i == 0) {
			jeProst = false;
			break;
		}
	}
	return jeProst;
}