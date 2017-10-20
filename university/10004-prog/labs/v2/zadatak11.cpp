#include <iostream>
#include <cmath>
using namespace std;

int main()
{
	float km;
	cout << "Unesite udaljenost u kilometrima: ";
	cin >> km;

	cout << km << " kilometara = " << km / 1.6 << " milja" << endl;

	return 0;
}