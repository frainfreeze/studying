#include <iostream>
using namespace std;

int main() {

	int brojA, brojB;
	bool brojJeProst = true;

	cout << "Unesite broj A: ";
	cin >> brojA;

	cout << "Unesite broj B: ";
	cin >> brojB;

	//FOR petlja za raspon brojeva
	for (int broj = brojA; broj < brojB; broj++)
	{
		//FOR petlja za provjeru da li je prost broj
		for (int j = 2; j < broj; j++)
		{
			if (broj % j == 0) {
				brojJeProst = false;
				break;
			}
			else
				brojJeProst = true;
		}

		if (brojJeProst)
			cout << broj << " ";
	}
	cout << endl;
	return 0;
}