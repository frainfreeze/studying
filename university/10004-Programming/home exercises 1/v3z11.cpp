#include <iostream>
using namespace std;

bool jeliProst(int broj) {
	for (int i = 2; i < broj ; i++)
	{
		if (broj%i == 0)
		{
			return false;
		}
		return true;
	}
}

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	if (jeliProst(broj)) {
		cout << "Broj " << broj << " je prost." << endl;
	}
	else
	{
		cout << "Broj " << broj << " nije prost." << endl;
	}
    return 0;
}

