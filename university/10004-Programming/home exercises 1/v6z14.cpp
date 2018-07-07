#include <iostream>
using namespace std;

int Faktorijel(int a)
{
	int umnozak = 1;
	for(int i = 1; i <= a; i++){
		umnozak *= i;
	}
	return umnozak;
}

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	cout << broj << "! = " << Faktorijel(broj);
		
	cout << endl;
	return 0;
}