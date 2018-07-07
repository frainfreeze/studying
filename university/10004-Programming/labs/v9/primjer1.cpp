#include <iostream>
#include <vector>
#include <string>
using namespace std;
  

struct Osoba {
	string Ime;
	string Prezime;
	int visina;
};


int main() {
	char temp;
	vector<Osoba> osobe;

	do
	{
		Osoba o;
		cout << "Ime: ";
		cin >> o.Ime;

		cout << "Prezime: " ;
		cin >> o.Prezime;

		cout << "Visina: ";
		cin >> o.visina;

		osobe.push_back(o);

		cout << "Dodati još osoba? (d/n)" << endl;
		cin >> temp;
	} while (temp == 'd');

	system("cls");
	cout << "Unesene osobe:\n\n";

	for (int i = 0; i < osobe.size(); i++)
	{
		cout << osobe[i].Ime << " " << osobe[i].Prezime << ", " << osobe[i].visina << "cm"<< endl;
	}

	return 0;
}
