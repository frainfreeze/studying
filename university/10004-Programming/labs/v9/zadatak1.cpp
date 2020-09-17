#include <iostream>
#include <vector>
#include <string>
#include <math.h>
using namespace std;


struct Kvadar {
	double a;
	double b;
	double c;
};


int main() {

	Kvadar z;
	cout << "Kvadar." << endl;
	cout << "stranica a: ";
	cin >> z.a;

	cout << "stranica b: ";
	cin >> z.b;

	cout << "stranica c: ";
	cin >> z.c;

	cout << "\nOplosje: " << 2 * (z.a *z.b + z.a*z.c + z.b*z.c);
	cout << "\nVolumen: " << (z.a*z.b*z.c);
	cout << "\nProstorna dijagonala: " << sqrt(pow(z.a,2)+ pow(z.b,2) + pow(z.c,2))<< endl;

	return 0;
}