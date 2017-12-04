#include <iostream>
#include <string>
using namespace std;

double pi=3.14;

void Kocka(){
	float a;
	cout << endl << "KOCKA";
	cout << endl << "Unesite duzinu stranice kocke: ";
	cin >> a;
	cout << endl << "Volumen kocke je: " << a*a*a;
	cout << endl << "Oplosje kocke je: " << 6*a*a;
}

void Valjak(){
	float r;
	float v;
	cout << endl << "VALJAK";
	cout << endl << "Unesite radijus: "; 
	cin >> r;
	cout << endl << "Unesite visinu: ";
	cin >> v;
	cout << endl << "Volumen valjka je: " << r*r*pi*v;
	cout << endl << "Oplosje valjka je: " << 2*r*pi*(r+v);
}

void Kugla(){
	float r;
	cout << endl << "KUGLA";
	cout << endl << "Unesite radijus kugle: ";
	cin >> r;
	cout << endl << "Volumen kugle je: " << (4.0/3.0)*(r*r*r*pi);
	cout << endl << "Oplosje kugle je: " << 4*r*r*pi;
}

int Izbornik(){
	int izbor;
	cout << "VOLUMEN I OPLOSJE";
	cout << endl << "-----------------------";
	cout << endl << "Izaberi: ";
	cout << endl << "\t1. Kocka";
	cout << endl << "\t2. Valjak";
	cout << endl << "\t3. Kugla";
	cout << endl << "> ";
	cin >> izbor;
	return izbor;
}

void Odabir(int izbor){
	switch (izbor){
		case 1:
			{
				Kocka();
				break;
			}
		case 2:
			{
				Valjak();
				break;
			}
		case 3:
			{
				Kugla();
				break;
			}
		}
}

int main(){

	int izbor=Izbornik();
	Odabir(izbor);	

	cout << endl;
	return 0;
}