#include <iostream>
using namespace std;

void Tablica(int a)
{
	for(int i = 1;i <= a; i++){
		for(int j = 1; j <= a; j++){
			cout << i * j << "\t";
		}
		cout << endl;
	}
}

int main()
{
	int broj;
	cout << "Unesite broj: ";
	cin >> broj;
	
	Tablica(broj);
	
	cout << endl;
	return 0;
}