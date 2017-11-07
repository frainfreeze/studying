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


int main() {

	pozdrav();
	IspisBrojevaDo100();
	return 0;
}