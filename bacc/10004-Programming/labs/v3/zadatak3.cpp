#include <iostream>
using namespace std;

// Napi�ite program koji s tipkovnice u�itava jedan cijeli broj N te ispisuje sve brojeve od njega do 16 * N.
int main()
{
	int broj;
	cout << "Unesite cijeli broj: " << endl;
	cin >> broj;

	int cilj = broj * 16;

	cout << endl;

	while (broj <= cilj){
		cout << broj++ << endl;
	}

	return 0;
}
