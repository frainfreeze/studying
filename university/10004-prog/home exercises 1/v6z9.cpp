#include <iostream>
using namespace std;

int SumaZnamenaka(int a){
	int suma = 0;
	while(a !=0)
	{
		suma += a % 10;
		a /= 10;
	}
	return suma;
}

int main(){

	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	int suma = SumaZnamenaka(broj);
	cout << "Suma zmanaka unesenog cijelog broja je: " << suma;
		
	cout << endl;
	return 0;
}