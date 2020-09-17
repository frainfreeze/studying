#include <iostream>
#include <vector>
#include <string>
using namespace std;

void IspisBrojeva(int* polje, int brojElemenata)
{
	for (int i = 0; i < brojElemenata; i++)
	{
		cout << polje[i] << endl;
	}
	cout << endl;
}


void main()
{
	int poljeBrojeva[5] = { 4, 78, 342, 657, 34 };
	IspisBrojeva(poljeBrojeva, 5);
}