#include <iostream>
using namespace std;

int Obrnuti(int a)
{
	int inv = 0;
	while(a != 0)
	{
		inv = inv * 10 + a % 10;
		a /= 10;
	}
	return inv;
}

int main(){

	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	cout << "Obrnuti uneseni broj je: " << Obrnuti(broj);
		
	cout << endl;
	return 0;
}