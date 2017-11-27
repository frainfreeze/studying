#include <iostream>
using namespace std;

int main(){
		
	int prirodniBroj, max;

	cout << "Za kraj unosa unesite 0.\n";
	cout << "Unesite prirodni broj: ";
	cin >> prirodniBroj;
	max = prirodniBroj;

	do 
	{
		if(prirodniBroj > max)
			max = prirodniBroj;

		cout << "Unesite prirodni broj: ";
		cin >> prirodniBroj;
	}
	while(prirodniBroj > 0);
	     
	cout << endl << "Najveci uneseni prirodni broj je: " << max << endl;
	return 0;
}
