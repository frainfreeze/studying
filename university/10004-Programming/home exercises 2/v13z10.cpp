#include <iostream>
#include <string>
using namespace std;

struct Pravokutnik {
	int a;
	int b;
};

int povrsina(Pravokutnik p) {
	return p.a * p.b;
}

int main() {

	int koliko;

	cout << "Koliko pravokutnika zelite ucitati: ";
	cin >> koliko;

	Pravokutnik* pravokutnici = new Pravokutnik[koliko];

	for (int i = 0; i < koliko; i++) {
		cout << "a: ";
		cin >> pravokutnici[i].a;
		cout << "b: ";
		cin >> pravokutnici[i].b;
	}

	int najmanja = povrsina(pravokutnici[0]);
	int najveca = najmanja;

	for (int i = 1; i < koliko; i++) {
		int trenutna = povrsina(pravokutnici[i]);
		if (trenutna < najmanja) {
			najmanja = trenutna;
		}
		else if (trenutna > najveca) {
			najveca = trenutna;
		}
	}

	delete[] pravokutnici;

	cout << "Najmanja povrsina je: " << najmanja << endl;
	cout << "Najveca povrsina je: " << najveca << endl;

	return 0;
}