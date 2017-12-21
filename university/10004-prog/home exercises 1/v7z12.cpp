#include <iostream>
#include <string>
#include <windows.h>
using namespace std;

void ispisi_udaljenosti(double nissan, double lexus) {
	cout << "Udaljenost Nissana GT-R: " << nissan << " km" << endl;
	cout << "Udaljenost Lexusa LFA: " << lexus << " km" << endl;
}

double izracunaj_novu_udaljenost(double automobil, double brzina_automobila) {
	return automobil - brzina_automobila;
}

bool kraj(double nissan, double lexus) {
	if (nissan <= 0 && lexus <= 0) {
		return true;
	}
	else {
		return false;
	}
}

int main() {

	double nissan = 1000;
	double lexus = 500;

	double brzina_nissana = 190;
	double brzina_lexusa = 105;

	while (true) {

		ispisi_udaljenosti(nissan, lexus);

		nissan = izracunaj_novu_udaljenost(nissan, brzina_nissana);
		lexus = izracunaj_novu_udaljenost(lexus, brzina_lexusa);

		// Je li kraj.
		if (kraj(nissan, lexus)) {
			cout << "Oba automobila su prosla kroz raskrizje." << endl;
			break;
		}
		
		Sleep(2000);
	}
	
	return 0;
}
