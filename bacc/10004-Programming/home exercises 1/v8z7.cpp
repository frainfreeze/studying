#include <iostream>
#include <string>
using namespace std;

int BrojRijeci(string recenica) {
	int brojRijeci = 1;
	for (int i = 0; i < recenica.size(); i++)
	{
		if (recenica[i] == ' ')
			brojRijeci++;
	}
	return brojRijeci;
}

void main() 
{
	string recenica;
	
	cout << "Unesite recenicu: ";
	getline(cin, recenica);
	cout << "Recenica sadrzi " << BrojRijeci(recenica) << " rijeci." << endl;

}