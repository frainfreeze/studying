#include <iostream>
using namespace std;

int Suma(int a)
{
	int suma = 0;
	for(int i = 1; i <= a; i++){
		suma += i;
	}
	return suma;
}

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	int suma=Suma(broj);

	cout << "Suma brojeva od 1 do " << broj << " je: " << suma;
		
	cout << endl;
	return 0;
}