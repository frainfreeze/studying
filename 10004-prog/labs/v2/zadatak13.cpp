#include <iostream>
#include <cmath>
using namespace std;

int main()
{
	double b1 = 92;
	double b2 = 97;
	double b3 = 95.4;
	double b4 = 90.1;
	double b5 = 96;

	double prosjek = (b1 + b2 + b3 + b4 + b5) / 5.0;

	double d1 = pow(b1 - prosjek, 2);
	double d2 = pow(b2 - prosjek, 2);
	double d3 = pow(b3 - prosjek, 2);
	double d4 = pow(b4 - prosjek, 2);
	double d5 = pow(b5 - prosjek, 2);


	double stdev = sqrt((d1 + d2 + d3 + d4 + d5) / 5.0);

	cout << "Prosjecna bacena vrijednost koplja je: " << prosjek << endl;
	cout << "Standardna devijacija je: " << stdev << endl;


	cout << endl;
}