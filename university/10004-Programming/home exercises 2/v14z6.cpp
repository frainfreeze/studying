#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;


void main()
{
	ofstream fileWriter("Neparni.txt");
	if (!fileWriter)
	{
		cout << "Datoteka Neparni.txt se ne moze kreirati!" << endl;
		return;
	}

	int broj;
	do
	{
		cout << "Unesite broj: ";
		cin >> broj;
		if (broj % 2 != 0)
			fileWriter << broj << endl;
	} while (broj != 0);
	fileWriter.close();

	/*ISPIS DATOTEKE Neparni.txt*/
	system("cls");
	cout << "Brojevi upisani u datoteku Neparni.txt" << endl << endl;
	ifstream fileReader("Neparni.txt");
	if (!fileReader)
	{
		cout << "Datoteka Neparni.txt se ne moze ucitati!" << endl;
		return;
	}
	
	int procitaniBroj;
	while (fileReader >> procitaniBroj)
	{
		cout << procitaniBroj << endl;
	}
	fileReader.close();
	cout << endl;
}