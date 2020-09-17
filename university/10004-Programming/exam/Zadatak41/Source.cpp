#include <iostream>
#include <string>
using namespace std;

struct Proizvod {
	int sifra;
	string naziv;
	double cijena;
};

int main() {
	Proizvod p1;
	cout << "Upisite sifru proizvoda: ";
	cin >> p1.sifra;
	cin.ignore();

	cout << "upisite naziv naziv proizvoda: ";
	getline(cin, p1.naziv);

	cout << "Upisite cijenu proizvoda: ";
	cin >> p1.cijena;

	cout << "\nsifra proizvoda je: " << p1.sifra
		<< "\nnaziv proizvoda: " << p1.naziv
		<< "\ncijena proizvoda: " << p1.cijena << endl;

	return 0;
}