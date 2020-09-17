#include <iostream>
#include <fstream>
using namespace std;

int main() {

	ifstream infile("brojevi.txt");
	if (!infile) {
		cout << "nemogu otvoriti datoteku!\n";
		return 1;
	}
	ofstream oParni("parni.txt");
	if (!oParni) {
		cout << "nemogu otvoriti datoteku za pisanje!\n";
		return 1;
	}
	ofstream oNeparni("neparni.txt");
	if (!oNeparni) {
		cout << "nemogu otvoriti datoteku za pisanje!\n";
		return 1;
	}

	int broj;
	while (infile >> broj) {
		if (broj % 2 == 0) oParni << broj << endl;
		else oNeparni << broj << endl;
	}

	infile.close();
	oParni.close();
	oNeparni.close();
	return 0;
}