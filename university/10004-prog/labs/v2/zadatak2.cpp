#include <iostream>
using namespace std;

int main() {
	
	double temp_f;
	cout << "Upisite temperaturu u F: ";
	cin >> temp_f;

	double temp_c = (temp_f - 32) * 5 / 9;
	
	cout << "Temperatura u C: " << temp_c << endl; 

	return 0;
}