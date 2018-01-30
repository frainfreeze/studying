#include <iostream>
#include <fstream>
#include <string>
using namespace std;

void main()
{
	ifstream fileReader("Brojevi.txt");

	if (!fileReader){
		cout << "Greška kod otvaranja datoteke ";
		return;
	}

	cout << "CITANJE PARNIH BROJEVA IZ DATOTEKE BROJEVI.TXT" << endl << endl;

	int broj;
	while (fileReader >> broj)
	{
		if (broj % 2 == 0)
			cout << broj << endl;
	}

	fileReader.close();
	cout << endl;
}