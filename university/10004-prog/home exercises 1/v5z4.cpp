#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main()
{
	vector <char> poljeSamoglasnika;
	string recenica;
	int a = 0;
	int e = 0;
	int i = 0;
	int o = 0;
	int u = 0;

	cout << "Unesite recenicu:" ;
	getline(cin, recenica);
	cout << endl;

	//Prolazimo kroz svaki znak recenice i provjeravamo da li je samoglasnik
	for (int i = 0; i < recenica.length(); i++)
	{
		switch (recenica[i])
		{
			case 'a':
			case 'e':
			case 'i':
			case 'o':
			case 'u':
				poljeSamoglasnika.push_back(recenica[i]);
				break;
			default:
				break;
		}
	}
	
	//Prebrojavanje samoglasnika
	for (int j = 0; j < poljeSamoglasnika.size(); j++)
	{
		switch (poljeSamoglasnika[j])
		{
			case 'a':
				a++;
				break;
			case 'e':
				e++;
				break;
			case 'i':
				i++;
				break;
			case 'o':
				o++;
				break;
			case 'u':
				u++;
				break;
		}
	}


	//Ispis samoglasnika
	cout << "Broj pojavljivanja samoglasnika: " << endl;
	cout << "a: " << "[" << a << "]" << endl;
	cout << "e: " << "[" << e << "]" << endl;
	cout << "i: " << "[" << i << "]" << endl;
	cout << "o: " << "[" << o << "]" << endl;
	cout << "u: " << "[" << u << "]" << endl;


	cout << endl << "Ukupno samoglasnika: " << poljeSamoglasnika.size();
	cout << endl << endl;

	return 0;
}