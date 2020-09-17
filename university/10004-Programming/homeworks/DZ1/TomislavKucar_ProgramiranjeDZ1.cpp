#include <iostream>
using namespace std;

int zbroji(int broj1, int broj2) {
	return broj1 + broj2;
}

int oduzmi(int broj1, int broj2) {
	return broj1 - broj2;
}

int pomnozi(int broj1, int broj2) {
	return broj1 * broj2;
}

double podijeli(int broj1, int broj2) {
	return broj1 / (double)broj2; //jedan broj moramo definirati kao double jer djeljenje intova vraca int
}

int najveciZajednickiDjelitelj(int broj1, int broj2) {
	//euklidov algoritam, moze se rjesiti i rekurzijom
	while (broj2 != 0)
	{
		int t = broj2;
		broj2 = broj1%broj2;
		broj1 = t;
	}
	return broj1;
}

int najmanjiZajednickiVisekratnik(int broj1, int broj2) {
	int brojac = 0;
	int ostatak1, ostatak2;
	
	//trazimo za koji broj (brojac) je ostatak djeljenja sa broj1 i broj2 nula tj najmanji zajednicki visekratnik
	do
	{
		brojac = brojac + 1;
		ostatak1 = brojac%broj1;
		ostatak2 = brojac%broj2;
	} while ((ostatak1 + ostatak2) != 0);
	return brojac;
}

int main()
{
	int broj1, broj2; //brojevi koje ce korisnik unjeti
	char oper; // za switch
	char dalje; // za provjeru nastavka izvrsavanja programa

	do
	{
		// 1. unos brojeva
		cout << "Unesite prvi broj: ";
		cin >> broj1;

		cout << "Unesite drugi broj: ";
		cin >> broj2;

		// 2. ispis izbornika i upit
		cout << "Unesite operaciju:" << endl;
		cout << "1. zbroj\n2. razlika\n3. umnozak\n4. kvocijent\n5. najveci zajednicki djelitelj\n6. najmanji zajednicki visekratnik" << endl;
		cin >> oper;

		// switchevi kojima pozivamo funkcije i ispisujemo rezultate
		switch (oper)
		{
		case '1': //zbroj
			int zbroj;
			zbroj = zbroji(broj1, broj2);
			cout << "Zbroj brojeva " << broj1 << " i " << broj2 << " je: " << zbroj << endl;
			break;

		case '2': //razlika
			int razlika;
			razlika = oduzmi(broj1, broj2);
			cout << "Razlika brojeva " << broj1 << " i " << broj2 << " je: " << razlika << endl;
			break;

		case '3': //umnozak
			int umnozak;
			umnozak = pomnozi(broj1, broj2);
			cout << "Umnozak brojeva " << broj1 << " i " << broj2 << " je: " << umnozak << endl;
			break;

		case '4': //kvocijent
			double kvocijent;
			kvocijent = podijeli(broj1, broj2);
			cout << "Kvocijent brojeva " << broj1 << " i " << broj2 << " je: " << kvocijent << endl;
			break;

		case '5': //najveci zajednicki djelitelj
			double najveci;
			najveci = najveciZajednickiDjelitelj(broj1, broj2);
			cout << "Najveci zajednicki djelitelj brojeva " << broj1 << " i " << broj2 << " je: " << najveci << endl;
			break;

		case '6': //najmanji zajednicki visekratnik
			double najmanji;
			najmanji = najmanjiZajednickiVisekratnik(broj1, broj2);
			cout << "Najmanji zajednicki visekratnik brojeva " << broj1 << " i " << broj2 << " je: " << najmanji << endl;
			break;

		default:
			cout << "Nepostojeca operacija." << endl;
			break;
		}


		// napokon, provjera zeli li korisnik nastaviti
		cout << "Zelite li nastaviti dalje (d-da, n-ne)? ";
		cin >> dalje;
	} while (dalje != 'n' && dalje == 'd');

	return 0;
}
