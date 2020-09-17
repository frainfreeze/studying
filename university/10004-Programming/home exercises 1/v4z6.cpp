#include <iostream>
using namespace std;

int main() {

	int raspored[3] ;
	int brojevi[3];
	int poz;
	
	cout << "Unos brojeva: " << endl;

	for (int j = 0; j <= 2; j++){
		cout << "Unesite " << j+1 << "." << " broj: ";
		cin >> brojevi[j];
		}
	cout << endl;

	cout << "Unos rasporeda ispisa: " << endl;

	for (int i = 0; i <= 2; i++){
		cout << "Unesite " << i+1 << "." << " broj koji ce se ispisati: ";
		cin >> raspored[i];
		}
	cout << endl;
	
		
	for (int k=0; k<=2; k++){
		poz = raspored[k];
		cout << poz << "-";
		cout << brojevi[poz-1] << ", "; 
	}

	cout << endl;
	return 0;
}