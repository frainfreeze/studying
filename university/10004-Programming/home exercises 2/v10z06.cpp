#include <iostream>
using namespace std;

struct Pravokutnik {
	int a;
	int b;
};

void opseg(Pravokutnik p) {
	int opseg = 2 * p.a + 2 * p.b;
	cout << "Opseg je: " << opseg << endl;
}

int main() {

	Pravokutnik p;
	p.a = 3;
	p.b = 4;

	opseg(p);

	return 0;
}