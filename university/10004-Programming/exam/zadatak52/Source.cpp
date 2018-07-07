#include <iostream>
#include <string>
#include <fstream>
using namespace std;

struct Adresa {
	string ulica;
	int kucniBr;
	int postBr;
};

void napraviAdresu(Adresa kuce[], string ulica, int kucniBr, int postBr, int n) {
	kuce[n] = { ulica,kucniBr,postBr };
}

int main() {
	Adresa kuce[3];
	napraviAdresu(kuce, "Vinogradska", 3, 51523, 0);
	napraviAdresu(kuce, "Ilica", 1, 10000, 1);
	napraviAdresu(kuce, "Draga baska", 33, 51522, 2);

	ofstream outfile("adrese.txt");
	if (!outfile) {
		cout << "nemogu otvoriti datoteku za pisanje!\n";
		return 1;
	}

	for (auto & i : kuce)
		outfile << i.ulica << "," << i.kucniBr << "," << i.postBr << endl;

	outfile.close();

	return 0;
}
