#include <iostream>
using namespace std;

int main()
{
	int broj = 16;
	int broj2 = 42;


	for (int i = broj; i <= broj2; i++)
	{
		cout << i << endl;
	}

	//kraj programa, mozemo reciklirati varijablu broj za while loop
	while (broj <= broj2)
	{
		cout << broj << endl;
		broj++;
	}

	return 0;
}