#include <iostream>
#include <ctime> 
#include <string>
using namespace std;

int Obrnuti(int broj)
{
	int obrnutiBroj = 0;
	while (broj != 0)
	{
		obrnutiBroj = obrnutiBroj * 10 + broj % 10;
		broj /= 10;
	}
	return obrnutiBroj;
}

void main() {
	int broj;
	cout << "Unesite broj:";
	cin >> broj;

	cout << "Obrnuti broj:";
	cout << Obrnuti(broj) << endl;
	cout << endl;
}


