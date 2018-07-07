#include <iostream>
#include <string>
#include <fstream>
using namespace std;

int main() {
	ifstream infile("odjevnipredmet.txt");
	if (!infile) {
		cout << "nemogu otvoriti datoteku!\n";
		return 1;
	}

	string line;
	// zadatak kaze da ucitmao 4 predmeta pa mozemo ovako
	for (int i = 0;  i < 4;  i++){
		getline(infile, line);
		cout << line << endl;
	}

	infile.close();

	return 0;
}
