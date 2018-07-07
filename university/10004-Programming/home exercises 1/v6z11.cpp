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

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	if(Obrnuti(broj) == broj)
		cout << "Uneseni broj je palindrom";
	else
		cout << endl << "Uneseni broj nije palindrom";
		
	cout << endl;
	return 0;
}