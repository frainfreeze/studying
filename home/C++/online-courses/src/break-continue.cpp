#include <iostream>
using namespace std;

int main() {

	const string password = "hello";

	string input;

	do {
		cout << "Enter your password > " << flush;
		cin >> input;

		if (input == password) {
			break;
		}
		else {
			cout << "Access denied." << endl;
		}

	} while (true);

	cout << "Password accepted" << endl;

	cout << "Program quitting ..." << endl;

	return 0;
}
