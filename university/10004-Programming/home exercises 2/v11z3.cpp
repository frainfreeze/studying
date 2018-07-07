#include <iostream>
#include <vector>
#include <string>
using namespace std;

void main()
{
	string polje[5];

	for (int i = 0; i < 5; i++)
	{
		cout << "Unesite " << (i + 1) << ".rijec: ";
		cin >> *(polje + i);
	}


	for (int i = 0; i < 5; i+=2)
	{
		cout << (i + 1) << ". rijec: " << *(polje + i) << endl;
	}
}