#include <iostream>
using namespace std;

//Zadatak 2. Napišite program koji s tipkovnice uèitava jedan cijeli broj te ispisuje je li on djeljiv
//s 3 ili 6. Inaèe ispisuje poruku “Ucitani broj nije djeljiv niti s 3 niti s 6”.

int main()
{
	int broj;
	cout << "Unesite cijeli broj: " << endl;
	cin >> broj;

	if ((broj % 3 == 0) || (broj % 6 == 0)) {
		cout << broj << " broj je djeljiv sa 3 ili 6." << endl;
	}
	else {
		cout << "Ucitani broj nije djeljiv niti s 3 niti s 6" << endl;
	}

	return 0;
}
