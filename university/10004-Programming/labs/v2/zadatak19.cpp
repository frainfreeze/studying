#include <iostream>
using namespace std;

int main()
{
	int broj = 42;
	int obrnutiBroj = 0;

	obrnutiBroj = (broj % 10) * 10 + broj / 10;

	cout << "Broj: " << broj << endl;
	cout << "Obrnuti broj: " << obrnutiBroj;
	cout << endl;
	return 0;
}