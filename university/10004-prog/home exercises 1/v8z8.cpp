#include <iostream>
#include <string>
#include <vector>
using namespace std;

void main()
{
	vector<vector<double>> ocjeneKolegija;
	vector<string> kolegiji;
	char ponovi;

	cout << "UNOS PREDMETA" << endl;
	do
	{
		string naziv;
		cout << "Naziv predmeta: ";
		cin >> naziv;
		//cin.ignore();
		//getline(cin, naziv);
		kolegiji.push_back(naziv);

		cout << "Dodati jos predmeta (d/n): ";
		cin >> ponovi;
	} while (ponovi == 'd');
	
	system("cls");
	cout << "UNOS OCJENA" << endl;

	for (int i = 0; i < kolegiji.size(); i++)
	{
		cout << endl << kolegiji[i] << endl << "------------" << endl;
		int redniBrojOcjene = 0;
		vector<double> ocjeneZaTrenutniKolegij;
		do
		{
			double ocjena;
			cout << ++redniBrojOcjene << ".ocjena: " ;
			cin >> ocjena;
			ocjeneZaTrenutniKolegij.push_back(ocjena);

			cout << "Dodati jos ocjena (d/n): ";
			cin >> ponovi;
		} while (ponovi == 'd');

		ocjeneKolegija.push_back(ocjeneZaTrenutniKolegij);
	}

	system("cls");
	cout << "ISPIS KOLEGIJA I OCJENA" << endl;

	for (int i = 0; i < kolegiji.size(); i++)
	{
		double suma = 0;
		cout << endl << endl << kolegiji[i] << endl << "------------" << endl;
		for (int j = 0; j < ocjeneKolegija[i].size(); j++)
		{
			suma += ocjeneKolegija[i][j];
			if (j == ocjeneKolegija[i].size() - 1)
				cout << ocjeneKolegija[i][j] << ".";
			else
				cout << ocjeneKolegija[i][j] << ", ";
		}
		cout << endl << "Prosjecna ocjena: " << suma / ocjeneKolegija[i].size() << endl;
	}

	cout << endl;

}