#include <iostream>
#include <string>
using namespace std;

bool sadrzi_i(string s) {
	for (int i = 0; i < s.size(); i++) {
		if (s[i] == 'i') {
			return true;
		}
	}
	return false;
}

int main() {

	int koliko;

	cout << "Koliko stringova zelite ucitati: ";
	cin >> koliko;
	cin.ignore();

	string* stringovi = new string[koliko];

	for (int i = 0; i < koliko; i++) {
		cout << "String: ";
		getline(cin, stringovi[i]);
	}

	for (int i = 0; i < koliko; i++) {
		if (sadrzi_i(stringovi[i])) {
			cout << stringovi[i] << endl;
		}
	}

	delete[] stringovi;

	return 0;
}