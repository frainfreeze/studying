#include <iostream>
using namespace std;

int BrZnamenki(int a)
{
	int brojac = 0;
	
	while(a != 0)
	{
		a /= 10;
		brojac++;
	}
	return brojac;
}

int main(){

	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	cout << "Broj znamenaka unesnog broja je: " << BrZnamenki(broj);

	cout << endl;
	return 0;
}