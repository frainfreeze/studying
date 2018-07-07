#include <iostream>
#include <vector>
#include <string>

using namespace std;

/*
Zadatak 4. Ucitajte recenicu od korisnika. 
Sve samoglasnike unesene recenice umetnite u polje. 
Ispisite broj pojavljivanja svakog samoglasnika i 
ukupan broj samoglasnika u recenici.
*/

int main() {

	//ucitajmo recenicu
	string recenica;
	int a = 0, e = 0, slovoi = 0, o = 0, u = 0;

	cout << "Unesite recenicu:\n";
	getline(cin, recenica);
	cin.ignore();

	vector<char> samoglasnici;

	// pronadimo samoglasnike i zabiljezimo njihov broj
	for (int i = 0; i < recenica.length(); i++)
	{
		if (recenica[i] == 'a') {
			samoglasnici.push_back(recenica[i]);
			a++;
		}
		else if(recenica[i] == 'e') {
			samoglasnici.push_back(recenica[i]);
			e++;
		}
		else if(recenica[i] == 'i') {
			samoglasnici.push_back(recenica[i]);
			slovoi++;
		}
		else if(recenica[i] == 'o') {
			samoglasnici.push_back(recenica[i]);
			o++;
		}
	    else if(recenica[i] == 'u') {
			samoglasnici.push_back(recenica[i]);
			u++;
		}
		else {
			// magic ;)
		}
	}

	for (int i = 0; i < samoglasnici.size(); i++)
	{
		cout << samoglasnici[i] << " ";
	}

	cout << "Imamo: " << a << " slova a, " << e << " slova e, " << slovoi << " slova i, " << o << " slova o, i " << u << " slova u.";
	cout << "\nUkupan broj samoglasnika: " << a + e + slovoi + o + u;
	cout << endl;
	return 0;
}