#include <iostream>
using namespace std;

int main() {
	
	double r;
	cout << "Upisite radijus kruznice: ";
	cin >> r;

	double pi = 3.1415;
	
	double povrsina = r * r * pi;
	double opseg = 2 * r * pi;
	
	cout << "Povrsina je: " << povrsina << endl; 
	cout << "Opseg je: " << opseg << endl; 

	return 0;
}