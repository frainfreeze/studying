#include <iostream>
#include <vector>

using namespace std;

/*
Zadatak 3. Napisite program koji od korisnika trazi da unese broj 
veci od 100 (ako je broj manji od 100 ponavlja se upit). 
Nakon unosa iz raspona (1 – broj) upisite sve parne brojeve u polje. 
Ispisite elemente polja odvojene zarezom. Nakon zadnjeg elementa stavite tocku
*/

int main() {

	int broj;
	vector<int> brojevi;

	do {
		cout << "Unesite broj veci od 100: ";
		cin >> broj;

		if (broj < 100) {
			cout << "Broj je manji od 100!" << endl;
		}
		else if (broj > 100) {

			//prodi kroz brojeve, nadi parne, dodaj ih u vektor
			for (int i = 1; i <= broj; i++)
			{
				if (i % 2 == 0) {
					brojevi.push_back(i);
				}
			}

			//ispis vektora
			for (int i = 0; i < size(brojevi); i++)
			{
				if (i == size(brojevi)-1){
					cout << brojevi[i] << ".";
				}
				else {
					cout << brojevi[i] << ", ";
				}
			}
			break;
		}
	} while (true);

	cout << endl;
	return 0;
}