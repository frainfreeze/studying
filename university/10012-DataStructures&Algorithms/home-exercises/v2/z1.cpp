#include <iostream>
#include <cmath>

using namespace std;

int multiply(int a, int b) 
{
	return a * b;
}

int divide(int a, int b) 
{
	// cjelobrojno dijeljenje s 0 nije greska u 
    // standardnom C++ pa bacamo gresku manually
	if (b == 0) {
        // ovo je visual studio specific!
		throw runtime_error("Djeljitelj ne smije biti 0!");
	}
	return a / b;
}

int square_root(int a) 
{
	// korijen negativnog broja ne baca gresku pa 
    // to takoder moramo manually
	if (a < 0) {
        // ovo je visual studio specific!
		throw exception("Broj ne smije biti manji od 0");
	}
	return sqrt(a);
}

int main() 
{
	int a;
	cout << "Unesite prvi broj:";
	cin >> a;

	int b;
	cout << "Unesite drugi broj:";
	cin >> b;

	cout << a << " * " << b << " = " << multiply(a, b) << endl;
	//hvatamo vlastito bacenu gresku
	try {
		cout << a << " / " << b << " = " << divide(a, b) << endl;
	}
	catch (const exception& e) {
		cout << "Pogreska: " << e.what() << endl;
	}

	try {
		cout << "sqrt(" << a << ") = " << square_root(a) << endl;
	}
	catch (const exception& e) {
		cout << "Pogreska: " << e.what() << endl;
	}

	return 0;
}