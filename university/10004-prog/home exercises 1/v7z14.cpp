#include <iostream>
using namespace std;

void ispisi_kvadrat(int n) {
	// Ako je proslijeðen neparni broj, kraj.
	if (n % 2 == 1) {
		return;
	}

	for (int j = 0; j < n; j++) 
	{
		for (int i = 0; i < n; i++) 
		{
			if (i < n / 2)
				cout << '*';
			else 
				cout << '#';
		}
		cout << endl;
	}
}

int main() 
{
	ispisi_kvadrat(3);
	cout << endl;

	ispisi_kvadrat(4);
	cout << endl;

	ispisi_kvadrat(10);
	cout << endl;
	
	ispisi_kvadrat(20);
	cout << endl;
	
	return 0;
}
