#include <iostream>
using namespace std;

//  Napi�ite program koji s tipkovnice u�itava jedan broj te ispisuje je li on paran ili ne.
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

