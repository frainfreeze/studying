#include <iostream>
using namespace std;

int main()
{
	int broj = 123;

	int L, S, D;

	L = broj / 100;
	S = (broj / 10) % 10;
	D = broj % 10;

	cout << "broj: " << broj << endl << endl;
	cout << "L: " << L << endl;
	cout << "S: " << S << endl;
	cout << "D: " << D << endl;

	return 0;
}