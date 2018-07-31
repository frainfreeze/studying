#include <iostream>
#include "Lampa.h"

using namespace std;

int main() 
{
	Lampa l1;
	l1.set_model("Antifoni");
	l1.set_proizvodac("Ikea");
	l1.set_broj_sijalica(1);
	l1.set_snaga(53);

	cout << l1.to_string() << endl;

	Lampa l2("Kvart");
	l2.set_proizvodac("Ikea");
	l2.set_broj_sijalica(3);
	l2.set_snaga(80);

	cout << l2.to_string() << endl;

	return 0;
}