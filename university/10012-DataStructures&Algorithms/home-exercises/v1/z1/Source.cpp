#include <iostream>
#include "Osoba.h"

using namespace std;

int main() 
{
	Osoba o1("Keljo", "Keglic", 123);
	o1.set_oib(123);
	cout << o1.to_string() << endl;

	o1.draw();

	return 0;
}
