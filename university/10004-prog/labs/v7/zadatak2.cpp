#include <iostream>
#include <cmath>

using namespace std;
const float PI = 3.1415927;

/*
Zadatak 2. Napisite program koji racuna volumen i oplosje kocke, kugle i valjka. Korisnik kroz izbornik bira
za koje tijelo zeli racunati volumen i oplosje. Izbornik i racunanje pojedinih vrijednosti rijesiti kroz
funkcije.
Formule za izracunavanje:
Kocka: V=a^3, O=6a^2
Kugla: V=(4/3)r^3π, O=4r^2π
Valjak: V=r^2πh, O=2rπ(r + h)
*/

void kocka() {
	int a;
	cout << "Unesite stranicu a: ";
	cin >> a;
	cout << "Volumen kocke iznosi: " << pow(a, 3) << " Oplosje kocke iznosi: " << (6 * pow(a, 2)) << endl;
}

void kugla() {
	int r;
	cout << "Unesite r: ";
	cin >> r;

	double cetrtri = 4 / 3; cout << cetrtri << endl;

	cout << "Volumen kugle iznosi: " << (4/(double)3 * PI * pow(r, 3)) << " Oplosje kugle iznosi: " << (4 * pow(r, 2) * PI) << endl;
	//krivi volumen ispisuje!
}


void valjak() {
	int r, h;
	cout << "Unesite r: ";
	cin >> r;
	cout << "Unesite h: ";
	cin >> h;
	cout << "Volumen valjka iznosi: " << (pow(r,2) * PI * h) << " Oplosje valjka iznosi: " << (2 * r * PI * (r+h)) << endl;
}

void Izbornik() {
	
	//initial output, odabir oblika
	char odabir;
	cout << "Program  racuna volumen i oplosje kocke, kugle i valjka.\n";
	cout << "Za koje tjelo zelite racunati? Unesite 1 za kocku, 2 za kuglu, 3 za valjak: ";
	cin >> odabir;

	//switch
	switch(odabir) {
	case '1':
		kocka();
		break;

	case '2':
		kugla();
		break;

	case '3':
		valjak();
		break;

   default: 
	   break;
	}

}

int main() {
	
	Izbornik();
	
	return 0;
}