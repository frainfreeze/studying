#include <iostream>
#include <string>
using namespace std;

int main() {
	
	int godina_rodjenja;
	string ime, prezime;
	bool redovan;
	char smjer;

	cout << "Godina rodjenja: ";
	cin >> godina_rodjenja;
	cin.ignore();

	cout << "Ime: ";
	getline(cin, ime);

	cout << "Prezime: ";
	getline(cin, prezime);

	cout << "Jeste li redovan student: ";
	cin >> redovan;

	cout << "Oznaka smjera (P, S ili M): ";
	cin >> smjer;

	cout << "------------------" << endl;
	cout << "Godina rodjenja: " << godina_rodjenja << endl;
	cout << "Ime: " << ime << endl;
	cout << "Prezime: " << prezime << endl;
	cout << "Redovan student: " << redovan << endl;
	cout << "Oznaka smjera: " << smjer << endl;

	return 0;
}