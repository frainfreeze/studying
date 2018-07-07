#include <iostream>
#include <vector>
#include <string>

using namespace std;

struct korisnik {
	string ime;
	int brojPosudbi;
};

int trenutniBrojPosudenihFilmova(vector<korisnik> korisnici) {
	int brojac = 0;
	for (int i = 0; i < korisnici.size(); i++)
	{
		brojac = brojac + korisnici[i].brojPosudbi;
	}
	return brojac;
}

int main() {
	char temp;
	char temp1;
	string temp2;
	vector<korisnik> korisnici;

	do
	{
		korisnik a;
		cout << "Ime korisnika: ";
		cin >> a.ime;

		cout << "Broj posudbi: ";
		cin >> a.brojPosudbi;

		korisnici.push_back(a);

		cout << "\nTrenutni broj posudbi: " << trenutniBrojPosudenihFilmova(korisnici);

		cout << "\nDodati jos korisnika? (d/n)" << endl;
		cin >> temp;
	} while (temp == 'd');

	system("cls");
	cout << "Pregled posudbi:\n";
	cout << "-----------------\n";
	do
	{
		system("cls");
		cout << ">ispis< za ispis svih posudbi\n>x< ispis posudbe s rednim brojem x\n";
		cin >> temp2;

	if (temp2 == "ispis")
	{
		for (int i = 0; i < korisnici.size(); i++)
		{
			cout << "Korisnik: " << korisnici[i].ime << endl;
			cout << "Broj posudbi: " << korisnici[i].brojPosudbi << endl;
			cout << "-----------------\n";
		}
		cout << "Ukupan broj posudbi: " << trenutniBrojPosudenihFilmova(korisnici);
	}
	else
	{
		int x = stoi(temp2);
		x = x - 1; //indeks krece od 0 ali korisnik to nezna

		if (x > korisnici.size())
		{
			cout << "nepostojeca posudba." << endl;
		}

		cout << "Posudba broj " << x+1 << ": " << korisnici[x].ime<< endl;
	}

	cout << "\nNastaviti? (d/n)" << endl;
	cin >> temp1;
	
	} while (temp1 == 'd');

	return 0;
}