#include <iostream>
#include <string>
using namespace std;

int index_of(string s, char c, int i) {
	for (int j = i; j < s.length(); j++) {
		if (s[j] == c) {
			return j;
		}
	}
	return -1;
}

int main() 
{
	string s;
	char c;

	cout << "Upisite rijec: ";
	getline(cin, s);

	cout << "Upisite znak kojeg trazite: ";
	cin >> c;

	cout << "Trazeni znak se nalazi na sljedecim pozicijama: " << endl;
	int pozicija = -1;
	do
	{
		pozicija = index_of(s, c, pozicija + 1);
		if (pozicija != -1) 
			cout << pozicija << endl;
	} while (pozicija != -1);
	
	return 0;
}
