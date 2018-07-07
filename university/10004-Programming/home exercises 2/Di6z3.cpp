#include <iostream>
#include <string>
using namespace std;

struct Auto {
	string naziv;
	int godina;
};

int main() {

	int stog1;
	int stog2;
	int* hrpa = new int;

	stog1 = 10;
	stog2 = 20;
	*hrpa = 130;

	cout << "Vrijednosti:" << endl;
	cout << stog1 << ", " << stog2 << ", " << *hrpa << endl;
	cout << "Adrese:" << endl;
	cout << "stog1: " << &stog1 << ", " << "stog2: " << &stog2 << ", " << "hrpa: " << hrpa << endl;

	int polje_stog[1];
	polje_stog[0] = 1;
	int *polje_hrpa = new int[1];
	polje_hrpa[0] = 1;

	//naziv polja je adresa polja, bilo na stogu ili heapu - ne treba koristiti &
	cout << "Adresa od polja na stogu: " << polje_stog << endl;
	cout << "Adresa od polja na hrpi: " << polje_hrpa << endl;

	cout << "Vrijednost nultog elementa polja na stogu koristeci []: " << polje_stog[0] << endl;
	cout << "Vrijednost nultog elementa polja na hrpi koristeci []: " << polje_hrpa[0] << endl;

	cout << "Vrijednost nultog elementa polja na stogu koristeci pointer: " << *polje_stog << endl;
	cout << "Vrijednost nultog elementa polja na hrpi koristeci pointer: " << *polje_hrpa << endl;

	delete hrpa;
	delete[] polje_hrpa;

	Auto a;
	Auto *pa = &a;
	pa->godina = 1989;
	pa->naziv = "BMW";

	cout << "Struct Auto ispisan preko pointera: " << pa->naziv << " " << pa->godina << endl;
	cout << "Struct Auto adresa: " << pa << endl;

	return 0;
}