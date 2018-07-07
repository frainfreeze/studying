#include <iostream>
#include <string>
using namespace std;

void IspisZnak(char z, int a){
	for (int i = 1; i <= a; i++) {
		for (int j = 1; j <= i; j++) {
			cout << z;
		}
		cout << endl;
	}
}


int main()
{
	char znak;
	int brRedaka;

	cout << "Unesite znak za ispis: ";
	cin >> znak;
	cout << "Unesite broj redaka: ";
	cin >> brRedaka;

	IspisZnak(znak, brRedaka);
	
	cout << endl;
	return 0;
}