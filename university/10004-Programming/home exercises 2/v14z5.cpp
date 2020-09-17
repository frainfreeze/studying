#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

void IspisBrojevauObrnutomRedoslijedu(vector<int> polje)
{
	system("cls");
	cout << "Ispis datoteke u obrnutom redoslijedu" << endl << endl;
	for (int i = polje.size() - 1; i >= 0; i--)
	{
		if (i > 0)
			cout << polje[i] << ", ";
		else
			cout << polje[i] << ".";
	}
}
int GetAritmetickaSredina(vector<int> poljeBrojeva)
{
	int suma = 0;
	for (int i = 0; i < poljeBrojeva.size(); i++)
	{
		suma += poljeBrojeva[i];
	}
	return suma / poljeBrojeva.size();
}
void IspisiMiniMax(vector<int> poljeBrojeva){
	int min = poljeBrojeva[0];
	int max = poljeBrojeva[0];

	for (int i = 0; i < poljeBrojeva.size(); i++)
	{
		if (poljeBrojeva[i] < min)
			min = poljeBrojeva[i];
		if (poljeBrojeva[i] > max)
			max = poljeBrojeva[i];
	}
	cout << "MIN: " << min << endl;
	cout << "MAX: " << max << endl;
}
void main()
{
	string fileName;
	vector<int> poljeBrojeva;

	cout << "Naziv datoteke u kojoj su brojevi: ";
	cin >> fileName;

	ifstream fileReader;
	fileReader.open(fileName);
	
	if (!fileReader)
	{
		cout << "Nije uspjelo citanje datoteke " << fileName << endl;
		return;
	}
	
	int procitaniBroj;
	while (fileReader >> procitaniBroj)
	{
		poljeBrojeva.push_back(procitaniBroj);
	}
	fileReader.close();

	IspisBrojevauObrnutomRedoslijedu(poljeBrojeva);
	cout << endl << endl;
	cout << "ARITMETICKA SREDINA: " << GetAritmetickaSredina(poljeBrojeva) << endl;
	IspisiMiniMax(poljeBrojeva);
	cout << endl << endl;
}