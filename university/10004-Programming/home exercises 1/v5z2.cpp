#include <iostream>
#include <vector>
using namespace std;

int main()
{
	vector <int> poljeBrojeva;
	int suma = 0;
	
	for (int i = 10; i <= 100; i++)
	{
		if(i%3 == 0)
			poljeBrojeva.push_back(i);
	}

	//Ispis u obrnutom redoslijedu
	cout << "Brojevi djeljivi s 3 iz raspona [10-100]" << endl;
	for (int i = poljeBrojeva.size() - 1; i >= 0; i--)
	{
		cout << poljeBrojeva[i] << " ";
		suma += poljeBrojeva[i];
	}

	cout << endl << endl;
	cout << "Suma brojeva djeljivih s 3: " << suma << endl << endl;
	return 0;
}