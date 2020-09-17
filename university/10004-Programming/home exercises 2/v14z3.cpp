#include <iostream>
#include <fstream>
#include <string>
using namespace std;

void CitajDatoteku(string imeDatoteke)
{
	ifstream fileReader;
	fileReader.open(imeDatoteke);
	
	if (!fileReader)
	{
		cout << "Datoteka " << imeDatoteke << " se ne moze ucitati!" << endl;
		return;
	}

	cout << "Citanje datoteke " << imeDatoteke << endl << endl;
	
	int broj;
	while (fileReader >> broj)
	{
		cout << broj << endl;
	}
	fileReader.close();
}

void main()
{
	ifstream fileReader("Brojevi.txt");
	ofstream fileWriterParni("ParniBrojevi.txt");
	ofstream fileWriterNeparni("NeparniBrojevi.txt");

	if (!fileReader){
		cout << "Nije uspjelo citanje datoteke Brojevi.txt" << endl;
	}

	int broj;
	while (fileReader >> broj)
	{
		if (broj % 2 == 0)
			fileWriterParni << broj << endl;
		else
			fileWriterNeparni << broj << endl;
	}

	fileReader.close();
	fileWriterNeparni.close();
	fileWriterParni.close();

	CitajDatoteku("ParniBrojevi.txt"); 
	cout << endl;
	CitajDatoteku("NeparniBrojevi.txt");
	return;
}