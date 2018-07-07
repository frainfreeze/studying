#include <iostream>
using namespace std;

int main() {

	int brojevi[10] = { 0,1,2,3,4,5,6,7,8,9 };

	for (int i = ((sizeof(brojevi) / sizeof(brojevi[0])) - 1); i >= 0; i--) {
		if (i % 2 == 0) {
			cout << "broj "<< brojevi[i] << " je paran"<< endl;
		}
		else {
			cout << "broj " << brojevi[i] << " je neparan" << endl;
		}

	}

	cout << endl;

	return 0;
}
