#include <iostream>
#include <string>
#include <vector>
using namespace std;

bool je_li_prost(int n) {
	for (int i = 2; i <= n - 1; i++) {
		if (n % i == 0) {
			return false;
		}
	}
	return true;
}

struct PrirodniBroj {
	int n;
	bool prost;
};

int main() {

	PrirodniBroj brojevi[1000];

	for (int i = 0; i < 1000; i++) {
		brojevi[i].n = i + 1;
		brojevi[i].prost = je_li_prost(i + 1);
	}

	cout << "Ispis prostih brojeva: " << endl;
	for (int i = 0; i < 1000; i++) {
		if (brojevi[i].prost == true) {
			cout << brojevi[i].n << " ";
		}
	}
	cout << endl;

	cout << "Ispis brojeva koji nisu prosti: " << endl;
	for (int i = 0; i < 1000; i++) {
		if (brojevi[i].prost == false) {
			cout << brojevi[i].n << " ";
		}
	}
	cout << endl;

	return 0;
}