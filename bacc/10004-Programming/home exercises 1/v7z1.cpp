#include <iostream>
#include <string>
using namespace std;


int Prebroji(string recenica, char c)
{
	int brojac = 0;
	for(int i = 0; i < recenica.size(); i++){
		if(recenica[i] == c)
			brojac++;
	}
	return brojac;
}

void Ispis(string recenica, char c, int brojac)
{
	cout << "U recenici: " << recenica << " se znak " << c << " pojavljuje " << brojac << " puta";
}

int main()
{
	string recenica;
	cout << "Unesite recenicu: ";
	getline(cin,recenica);
	char c;
	cout << "Unesite znak: ";
	cin >> c;

	int brojac=Prebroji(recenica, c);
	Ispis(recenica,c, brojac);

	cout << endl;
	return 0;
}