#include <iostream>
using namespace std;

int main() {

	int brojevi[10] ;
	
	for (int i = 0; i <10; i++)
	{
		cout << "Unesite " << i+1 << "." << " broj: ";
		cin >> brojevi[i];
	}

	cout << endl;
	
	for (int i = 9; i>=0; i--)
	{
		if (i == 0)
			cout << brojevi[i] << ".";
		else 
			cout << brojevi[i] << ",";
	}
	
	cout << endl;
	return 0;
}