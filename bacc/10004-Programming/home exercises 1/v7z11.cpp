#include <iostream>
using namespace std;

int vrati_najvecu_kovanicu(int za_vratiti) 
{
	if (za_vratiti >= 5) 
		return 5;
	else if (za_vratiti >= 2) 
		return 2;
	else if (za_vratiti >= 1) 
		return 1;
}

int main() {

	int cijena_kave = 4;
	int ubacio;

	cout << "Ubacite novac: ";
	cin >> ubacio;

	int za_vratiti = ubacio - cijena_kave;
	
	int kovanica;
	while (za_vratiti > 0) {
		kovanica = vrati_najvecu_kovanicu(za_vratiti);
		
		cout << "Vracam kovanicu od " << kovanica << " kuna" << endl;
		za_vratiti -= kovanica;
	}

	return 0;
}