#include <iostream>
using namespace std;

void Ispis(int a, int b){

	if(b < a){
		int temp = a;
		a = b;
		b = temp;
	}

	for(int i = a; i <= b; i++){
		cout << i << " ";
	}
	
}

int main(){

	int broj1, broj2;		;
	cout << "Unesite 1. broj: ";
	cin >> broj1;
	cout << "Unesite 2. broj: ";
	cin >> broj2;

	Ispis(broj1,broj2);

	cout << endl;
	return 0;
}