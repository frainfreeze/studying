#include <iostream>
#include <string>
using namespace std;

int main() {
	cout << "Koliko stringova zelite ucitati? ";
	int brojstr;
	cin >> brojstr;
	cin.ignore();
	string * polje = new string[brojstr];
	
	string line;
	for (int i = 0; i < brojstr; i++){
		cout << "Upisite " << i + 1 << ". string: ";
		getline(cin, line);
		polje[i] = line;
	}

	cout << endl;
	for (int i = brojstr - 1; i >= 0; i--){
		cout << polje[i] << endl;
	}

	delete[] polje;

	return 0;
}