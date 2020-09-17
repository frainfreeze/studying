#include <iostream>
#include <iomanip>
using namespace std;

void IspisIIzracun(double ulog, double godisnja_kamta, int period)
{
	double mjesecna_kamata =(godisnja_kamta/100)/12;
	double ukupna_kamata = 0.00;
	double stanje_racuna = ulog;
	double kamatni_iznos;

	cout << endl << endl;
	cout << "           MJESECNI       UKUPAN          NOVO" << endl;
	cout << " MJESEC    KAMATNI IZNOS  KAMATNI IZNOS   STANJE" << endl;
	cout << "----------------------------------------------------";

	for(int mjesec=1;mjesec <=period; mjesec++)
	{
		kamatni_iznos= mjesecna_kamata*stanje_racuna;
		stanje_racuna +=kamatni_iznos;
		ukupna_kamata +=kamatni_iznos;
		cout << endl << setw(4) << mjesec
			 << setw(14) << kamatni_iznos
			 << setw(16) << ukupna_kamata
			 << setw(14) << stanje_racuna;
	}

	cout << endl;
	cout << "--------------------------------------------------"<< endl;
	cout << endl << "\tUkupno: " << endl << endl;
	cout << "Pocetni ulog: " << setw(10) << ulog << endl;
	cout << "Kamata: " << setw(10) << ukupna_kamata << endl;
	cout << "Krajnja suma: " << setw(10) << stanje_racuna << endl;
}


int main()
{   
	double ulog, godisnja_kamata;
	int mjesec, period;

	cout << setprecision(2)
		 << setiosflags(ios::fixed)
		 << setiosflags(ios::showpoint);
	
	cout << "Unesite visinu uloga: ";
	cin >> ulog;
	cout << "Unesite period (u mjesecima): ";
	cin >> period;
	cout << "Unesite godisnju kamatnu stopu: ";
	cin >> godisnja_kamata;

	IspisIIzracun(ulog, godisnja_kamata,period);

	cout << endl;
	return 0;
}