#include <iostream>
#include <fstream>
#include <string>
using namespace std;

void main()
{
	string fileNameRead, fileNameWrite;
	cout << "Unesite naziv datoteke: ";
	cin >> fileNameRead;

	ifstream fileReader;
	fileReader.open(fileNameRead);

	if (!fileReader)
	{
		cout << "Nije uspjelo ucitavanje datoteke " << fileNameRead << endl;
		return;
	}

	cout << "Navedite ime datoteke u koju ce se kopirati vrijednosti procitane u datoteci " << fileNameRead << ": ";
	cin >> fileNameWrite;

	ofstream fileWriter;
	fileWriter.open(fileNameWrite);
	if (!fileWriter)
	{
		cout << "Datoteka " << fileNameWrite << " se ne moze kreirati!" << endl;
		return;
	}

	string procitanaVrijednost;
	while (getline(fileReader, procitanaVrijednost))
	{
		fileWriter << procitanaVrijednost << endl;
	}

	fileReader.close();
	fileWriter.close();

	cout << endl << "Datoteka " << fileNameWrite << " je uspjesno kreirana!" << endl;
}