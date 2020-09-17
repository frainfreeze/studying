#include <iostream>
using namespace std;

//Ispisite koliko slova o se nalazi u recenici „Koliko slova o ima u ovoj recenici?”

int main() {

	cout << "Koliko slova o ima u ovoj recenici?" << endl;

	char polje[] = "Koliko slova o ima u ovoj recenici?";

	int velicinaPolja = sizeof(polje);
	int velicinaChar = sizeof(char);
	int brojClanovaPolja = velicinaPolja / velicinaChar;

	int brojac = 0;

	for (int i = 0; i < brojClanovaPolja; i++)
	{
		if (polje[i] == 'o') {
			brojac++;
		}
	}

	cout << "Znak o se pojavljuje " << brojac << " puta.";
	cout << endl;
	return 0;
}
