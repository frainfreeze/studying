#include <iostream>
#include <string>
using namespace std;

string Unos()
{
	string recenica;
	cout << "Unesite recenicu: ";
	getline(cin, recenica);

	return recenica;
}

int Prebrojavanje(string s){
	int brojac=0;
	for (int i = 0; i < s.length(); i++) {
		if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
			brojac++;
		}
	}
	return brojac;
}

int Razmak(string s)
{
	int brRazmaka=0;
	for (int i = 0; i < s.length(); i++) {
		if (s[i] == ' ') {
			brRazmaka++;
		}
	}
	return brRazmaka;
}

int main()
{
	string recenica;
	recenica = Unos();

	int brojSamoglasnika=Prebrojavanje(recenica);
	int brRazmaka=Razmak(recenica);
	
	cout << endl << "Broj samoglasnika: " << brojSamoglasnika;
	cout << endl << "Broj suglasnika: " << recenica.length() - brRazmaka - brojSamoglasnika;
		
	cout << endl;
	return 0;
}