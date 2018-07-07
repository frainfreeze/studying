#include <iostream>
#include <cmath>
using namespace std;

int main()
{
	int student1, student2, student3;

	cout << "Unesite visinu 1.studenta: ";
	cin >> student1;
	cout << "Unesite visinu 2.studenta: ";
	cin >> student2;
	cout << "Unesite visinu 3.studenta: ";
	cin >> student3;

	cout << endl << "Prosjecna visina je: " << (student1 + student2 + student3) / 3.0;

	cout << endl;
	return 0;
}