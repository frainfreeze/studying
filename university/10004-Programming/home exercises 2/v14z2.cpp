#include <iostream>
#include <fstream>
#include <string>
using namespace std;

void main()
{
	ifstream fileReader("Brojevi.txt");
	if (!fileReader){
		cout << "Nije ucitana datoteka Brojevi.txt" << endl;
		return;
	}

	int broj;
	int ukupnoBrojeva = 0, sumaBrojeva = 0;
	
	while (fileReader >> broj)
	{
		cout << "Procitan broj: " << broj << endl;
		ukupnoBrojeva++;
		sumaBrojeva += broj;
	}
	fileReader.close();

	cout << endl;
	cout << "ARIT.SREDINA: " << (sumaBrojeva / ukupnoBrojeva) << endl;
	cout << "SUMA BROJEVA: " << sumaBrojeva << endl;

}