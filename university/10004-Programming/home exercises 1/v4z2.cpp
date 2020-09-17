#include <iostream>
using namespace std;

int main() {

	int brojevi[10] = { 5, 7, 9, 1, 4, 67, 5, 4, 8, 6 };

	for (int i = 9; i>=0; i--)
	{
		if (i==0)
			cout << brojevi[i] << ".";
		else 
			cout << brojevi[i] << ",";
	}
	
	cout << endl;
	return 0;
}