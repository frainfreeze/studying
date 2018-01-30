#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

struct Knjiga
{
	string Naslov, Autor;
	int Kolicina;
};
void UcitajKnjigeuPolje(Knjiga* polje, int velicinaPolja)
{
	ifstream fileReader("PodacioKnjigama.txt");
	if (!fileReader)
	{
		cout << "Nije moguce ucitati datoteku Knjige.txt" << endl;
		return;
	}

	for (int i = 0; i < velicinaPolja; i++)
	{
		getline(fileReader, polje[i].Naslov, '|');
		getline(fileReader, polje[i].Autor, '|');
		fileReader >> polje[i].Kolicina;
		fileReader.ignore();
	}
	fileReader.close();
}
void IspisPoljaKnjiga(Knjiga* polje, int velicinaPolja)
{
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << "AUTOR: " << polje[i].Autor << endl;
		cout << "NASLOV: " << polje[i].Naslov << endl;
		cout << "KOLICINA: " << polje[i].Kolicina << endl;
		cout << endl;
	}
}
void UpisiKnjigeuDatoteku(Knjiga* polje, int velicinaPolja){
	ofstream fileWriter("Knjige.txt");
	if (!fileWriter){
		cout << endl << "Greska pri pisanju";
		return;
	}

	for (int i = 0; i < velicinaPolja; i++)
	{
		fileWriter << endl << "Knjiga " << i + 1 << ".:";
		fileWriter << endl << "\tNaslov: " << polje[i].Naslov;
		fileWriter << endl << "\tAutor: " << polje[i].Autor;
		fileWriter << endl << "\tKolicina: " << polje[i].Kolicina;
		fileWriter << endl;
	}
	fileWriter.close();
}
void main()
{
	Knjiga kolekcijaKnjiga[3];
	UcitajKnjigeuPolje(kolekcijaKnjiga, 3);
	IspisPoljaKnjiga(kolekcijaKnjiga, 3);
	UpisiKnjigeuDatoteku(kolekcijaKnjiga, 3);
}