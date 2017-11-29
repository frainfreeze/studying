#include <iostream>
#include <string>
using namespace std;


int main()
{
		
	cout << "Recenica: Koliko slova o ima u ovoj recenici?" << endl << endl;
	int brojPojavljivanja = 0;				

	char X[] = "Koliko slova o ima u ovoj recenici?";

	int velicina = sizeof(X) / sizeof(char);

	for (int i = 0; i < velicina; i++){
		if(X[i] == 'o')
			brojPojavljivanja++;
	}

	/*
		string recenica = "Koliko slova o ima u ovoj recenici?";
		for (int i = 0; i < recenica.length(); i++)
		{
			if (recenica[i] == 'o')
				brojPojavljivanja++;
		}
	*/
	cout << "Slovo o se pojavljuje " << brojPojavljivanja << " puta." << endl << endl;
	
	return 0;
}
