#include <iostream>
using namespace std;

int main() {

	int a, b;

	cout << "Unesite broj A: ";
	cin >> a; //sirina

	cout << "Unesite broj B: ";
	cin >> b; //visina


	for (int i = 0; i < a; i++)
	{
		for (int j = 0; j < b; j++)
		{
			cout << "*";
		}
		cout << endl;
	}

	cout << endl;
	return 0;
}