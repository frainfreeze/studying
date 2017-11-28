#include <iostream>
using namespace std;

int main() {

	int brojevi[5] ;
	int djeljitelj;
	
	for (int i = 0; i <5; i++)
	{
		cout << "Unesite " << i+1 << "." << " broj: ";
		cin >> brojevi[i];
	}
	
	cout << endl;
	cout << "Unesite jos jedan broj: ";
	cin >> djeljitelj;
		
	for (int i = 0; i<5; i++)
	{
		cout << brojevi[i] << " % " << djeljitelj << " = " << brojevi[i]%djeljitelj << endl;
	}
	
	cout << endl;
	return 0;
}