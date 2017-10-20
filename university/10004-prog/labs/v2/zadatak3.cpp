#include <iostream>
#include <string>
#include <cmath>
using namespace std;

int main() {
	
	double a1 = 2;
	double a2 = 4;
	double a3 = 4;
	double a4 = 4;
	double a5 = 5;
	double a6 = 5;
	double a7 = 7;
	double a8 = 9;

	double prosjek = (a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8) / 8;

	double d1 = pow(a1 - prosjek, 2);
	double d2 = pow(a2 - prosjek, 2);
	double d3 = pow(a3 - prosjek, 2);
	double d4 = pow(a4 - prosjek, 2);
	double d5 = pow(a5 - prosjek, 2);
	double d6 = pow(a6 - prosjek, 2);
	double d7 = pow(a7 - prosjek, 2);
	double d8 = pow(a8 - prosjek, 2);

	double stdev = sqrt((d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8) / 8.0);

	cout << "Prosjecna pogodjena vrijednost je: " << prosjek << endl;
	cout << "Standardna devijacija je: " << stdev << endl;

	return 0;
}