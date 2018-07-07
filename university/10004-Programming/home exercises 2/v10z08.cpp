#include <iostream>
#include <string>
using namespace std;

struct Student {
	string ime;
	string prezime;
	string jmbag;
};

int main() {

	Student studenti[5];

	studenti[0].ime = "Miro";
	studenti[0].prezime = "Miric";
	studenti[0].jmbag = "0015292141";

	studenti[1].ime = "Ana";
	studenti[1].prezime = "Anic";
	studenti[1].jmbag = "9856131";

	studenti[2].ime = "Iva";
	studenti[2].prezime = "Ivic";
	studenti[2].jmbag = "895564564";

	studenti[3].ime = "Juro";
	studenti[3].prezime = "Juric";
	studenti[3].jmbag = "0251121121";

	studenti[4].ime = "Anka";
	studenti[4].prezime = "Ankic";
	studenti[4].jmbag = "80455121";

	string trazeni_jmbag;
	cout << "Upisite trazeni JMBAG: ";
	getline(cin, trazeni_jmbag);

	bool pronasao = false;
	for (int i = 0; i < 5; i++) {
		if (studenti[i].jmbag == trazeni_jmbag) {
			cout << "Trazeni JMBAG pripada studentu: " << studenti[i].ime << " " << studenti[i].prezime << endl;
			pronasao = true;
			break;
		}
	}
	
	if (pronasao == false) {
		cout << "Trazeni JMBAG ne pripada niti jednom studentu." << endl;
	}

	return 0;
}