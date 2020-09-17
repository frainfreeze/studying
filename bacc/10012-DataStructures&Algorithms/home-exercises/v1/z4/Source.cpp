#include <iostream>
#include "RucniMjenjac.h"

using namespace std;

int main() 
{
	RucniMjenjac m;
	
	cout << m.to_string() << endl;
	m.prema_dolje();
	
	cout << m.to_string() << endl;
	cout << "prema gore:" << endl;
	
	for (int i = 0; i < 5; i++){
		m.prema_gore();
		cout << m.to_string() << endl;
	}

	cout << "prema dolje:" << endl;

	for (int i = 0; i < 5; i++) {
		m.prema_dolje();
		cout << m.to_string() << endl;
	}

	return 0;
}