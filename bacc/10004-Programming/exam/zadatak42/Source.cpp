#include <iostream>
using namespace std;

struct Pravokutnik {
	double sirina, visina;
};

void ispisPrav(Pravokutnik p1, Pravokutnik p2);

int main() {
	Pravokutnik p1, p2;

	cout << "Upisite sirinu prvog pravokuntika: ";
	cin >> p1.sirina;

	cout << "Upisite visinu prvog pravokuntika: ";
	cin >> p1.visina;

	cout << "Upisite sirinu drugog pravokuntika: ";
	cin >> p2.sirina;

	cout << "Upisite visinu drugog pravokuntika: ";
	cin >> p2.visina;

	ispisPrav(p1, p2);

	return 0;
}

void ispisPrav(Pravokutnik p1, Pravokutnik p2) {
	double pov1 = p1.sirina*p1.visina;
	double pov2 = p2.sirina*p2.visina;
	double ukpov = pov1 + pov2;
	cout << "\nUkupna povrsina oba pravokutnika je " << ukpov << ".\n";
}