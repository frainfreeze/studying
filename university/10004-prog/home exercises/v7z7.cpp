#include <iostream>
#include <string>
using namespace std;

void Ispis(int a, int b, int c)
{
	if (a > b) {
		return;
	}
	cout << a << " ";
	Ispis(a + c, b, c);
}

int main()
{   
	int a, b, c;

	cout << "Unesite 1. broj: ";
	cin >> a;
	cout << "Unesite 2. broj: ";
	cin >> b;
	cout << "Unesite korak: ";
	cin >> c;

	Ispis(a, b, c);
    
	cout << endl;
	return 0;
}