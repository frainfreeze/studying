#include <iostream>
using namespace std;

void pozdrav() {
	cout << "Hey" << endl;
}

void IspisBrojevaDo100() {
	for (int i = 0; i <= 100; i++)
	{
		if (i == 100) {
			cout << i << ".";
		}
		else {
			cout << i << ", ";
		}
	}
	cout << endl;
}

int DvaPlusDva() {
	return 4;
}

int ZbrojBrojeva(int a, int b) {
	return a+b;
}

int main() {

	//pozdrav();
	//IspisBrojevaDo100();
	//cout << DvaPlusDva() << endl;
	int a, b;
	cout << "unesite broj a: ";
	cin >> a;

	cout << "unesite broj b: ";
	cin >> b;

	cout << "zbroj brojeva " << a << " i " << b << " iznosi: " << ZbrojBrojeva(a, b) << endl;
	return 0;
}
