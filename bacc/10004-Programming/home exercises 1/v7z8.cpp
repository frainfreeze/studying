#include <iostream>
#include <string>
using namespace std;

void Ispis(int a, int n){
	if (a > n) {
		return;
	}
	if (a % 2 == 0) {
		cout << a << " ";
	}
	Ispis(a + 1, n);
}


int main()
{   
	int broj;
    cout << "Unesite broj veci od 1: ";
	cin >> broj;
    
	Ispis(1, broj);
	   
	cout << endl;
	return 0;
}