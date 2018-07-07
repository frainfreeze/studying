#include <iostream>
#include <vector>
#include <string>
using namespace std;

/*
Zadatak 1. Napisite program koji ucitava recenicu od korisnika i jos jedan znak. 
Program treba izracunati koliko puta se uneseni znak pojavljuje u recenici. 
Prebrojavanje odradite kroz funkciju Prebroji, a ispis kroz funkciju Ispis.
*/

int Prebroji(string recenica, char znak) {
	vector<char> slovca;

	for (int i = 0; i < recenica.length(); i++)
	{
		if (recenica[i] == znak) {
			slovca.push_back(recenica[i]);
		}
	}
	
	return slovca.size();
}

void Ispis(int broj, char znak) {
	cout << "U unesenoj recenici ima " << broj << " znakova " << znak << endl;
}

int main() {
	//ucitajmo recenicu
    string recenica;
	cout << "Unesite recenicu:\n";
	getline(cin, recenica);
	cin.ignore();

	//znak
	char znak;
	cout << "Unesite znak: ";
	cin >> znak;
	
	int broj;
	broj = Prebroji(recenica, znak);
	Ispis(broj, znak);
	return 0;
}

