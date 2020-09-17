#include <iostream>
#include <vector>

using namespace std;

/*
Zadatak 3. Napisite program koji ispisuje koji su brojevi u zadanom rasponu prosti.
Korisnik unosi donju i gornju granicu raspona.
Provjeru da li je broj prost rijesite unutar funkcije.
*/


bool jeliProst(int broj) {


	for (int i = 2; i <= broj / 2; ++i)
	{
		if (broj % i == 0)
		{
			return true;
		}
	}
	return false;
}



int main() {
	int brojac = 0;
	vector<int> raspon;

	// unos pocetka i kraja
	int start, end;
	cout << "unesite pocetni broj raspona: ";
	cin >> start;
	cout << "unesite zadnji broj raspona: ";
	cin >> end;

	// popuniti polje
	for (int i = start; i <= end; i++)
	{
		raspon.push_back(i);
	}

	// proci kroz polje i pronaci proste
	for (int i = 0; i < raspon.size(); ++i)
	{
		if (jeliProst(i) == true)
		{
			brojac++;
		}
	}

	// ispis rezultata
	cout << "U unesenom rasponu ima " << brojac << " prostih brojeva." << endl;
	return 0;
}