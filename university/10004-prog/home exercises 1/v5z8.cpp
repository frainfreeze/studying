#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main()
{
	vector <string> poljeIme;
	vector <string> poljePrezime;
	vector <int> poljeGodine;
	char ponovi;

	do
	{
		cout << endl;

		string ime;
		cout << "Ime: ";
		cin >> ime;
		poljeIme.push_back(ime);

		string prezime;
		cout << "Prezime: ";
		cin >> prezime;
		poljePrezime.push_back(prezime);

		int godine;
		cout << "Godine: ";
		cin >> godine;
		poljeGodine.push_back(godine);
		
		cout << endl;

		cout << "Dodati jos osoba (d/n): ";
		cin >> ponovi;
	} while (ponovi == 'd' || ponovi == 'D');

	cout << endl;
	int redniBroj = 0;

	do
	{
		cout << "Redni broj osobe cije informacije zelite ispisati [1-" << poljeIme.size() << "]: ";
		cin >> redniBroj;

		if (redniBroj < 1 || redniBroj > poljeIme.size())
			cout << "Krivo unesen redni broj." << endl;
	} while (redniBroj < 1 || redniBroj > poljeIme.size());
	
	cout << endl;
	cout << "Ime: " << poljeIme[redniBroj - 1] << endl;
	cout << "Prezime: " << poljePrezime[redniBroj - 1] << endl;
	cout << "Godine: " << poljeGodine[redniBroj - 1] << endl;
	cout << endl;

	return 0;
}