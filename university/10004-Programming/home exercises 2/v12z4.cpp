#include <iostream>
#include <string>
using namespace std;

void Ispis1(int* polje, int n){
	cout << endl;
	for (int i = 0; i < n; i++) {
		cout << polje[i] << " ";
	}
}
void Ispis2(double* polje, int n){
	cout << endl;
	for (int i = 0; i < n; i++) {
		cout << polje[i] << " ";
	}
}
void Ispis3(float* polje, int n){
	cout << endl;
	for (int i = 0; i < n; i++) {
		cout << polje[i] << " ";
	}
}
void Ispis4(char* polje, int n){
	cout << endl;
	for (int i = 0; i < n; i++) {
		cout << polje[i] << " ";
	}
}
void Ispis5(string* polje, int n){
	cout << endl;
	for (int i = 0; i < n; i++) {
		cout << polje[i] << " ";
	}
}


void main()
{
	int polje1[5] = {1,2,3,4,5};
	double polje2[5] = {1.1,2.2,3.3,4.4,5.5};
	float polje3[5] = {10.1,10.2,10.3,10.4,10.5};
	char polje4[5] = {'a','b','c','d','e'};
	string polje5[5] = {"pon","uto","sri","cet","pet"};

	Ispis1(polje1,5);
	Ispis2(polje2,5);
	Ispis3(polje3,5);
	Ispis4(polje4,5);
	Ispis5(polje5,5);

	cout << endl;
}