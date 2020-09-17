#include <iostream>

#include "Pravokutnik.h"

using namespace std;

int main() 
{
	try {
		//Pravokutnik p(-5, 8);
		//Pravokutnik p(5, -8);
		Pravokutnik p(5, 8);

		cout << p.shape('x', '-', true);
		cout << endl;
		cout << p.shape('x', '-', false);
	}
	catch (const exception &e) {
		cout << "Pogreska: " << e.what() << endl;
	}

	return 0;
}