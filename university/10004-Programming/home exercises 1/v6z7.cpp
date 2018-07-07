#include <iostream>
using namespace std;

bool paran(int a)
{
	if(a % 2 == 0)
		return true;	
	else
		return false;
}

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	if(paran(broj))
		cout << "Uneseni broj je paran!";
	else
		cout << "Uneseni broj je neparan!";
	
	cout << endl;
	return 0;
}