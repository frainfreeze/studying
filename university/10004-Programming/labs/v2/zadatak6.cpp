#include <iostream>
using namespace std;

int main() {
	
	int prvi_broj = 45;
	int drugi_broj = 6;

	// S pomocnom varijablom:
	int zbroj = prvi_broj + drugi_broj;

	cout << zbroj << endl;

	// Bez pomocne varijable.
	cout << prvi_broj + drugi_broj << endl;

	return 0;
}