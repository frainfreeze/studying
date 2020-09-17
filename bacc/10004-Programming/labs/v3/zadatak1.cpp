#include <iostream>
using namespace std;

//  Napišite program koji s tipkovnice uèitava jedan broj te ispisuje je li on paran ili ne.
int main()
{
	int broj;
	cout << "Unesite broj: " << endl;
	cin >> broj;

	if (broj % 2 == 0) {
		cout << broj << " je paran." << endl;
	}
	else {
		cout << broj << " je ne paran." << endl;
	}

	return 0;
}

