#include <iostream>
using namespace std;

int main() {

	int brojevi[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	
	for (int i = 0; i < 10; i++)
	{
		if (brojevi[i] % 2 == 0)
			cout << brojevi[i] << " je paran." << endl;
		else 
			cout << brojevi[i] << " je neparan." << endl;
	}
	
	
	cout << endl;
	return 0;
}