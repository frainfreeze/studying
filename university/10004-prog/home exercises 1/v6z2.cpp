#include <iostream>
using namespace std;

void Ispis(int a){
	for(int i = 1; i <= a; i++){
		cout << i << " ";
	}
}

int main(){

	int broj;
	cout << "Unesite broj: ";
	cin >> broj;

	Ispis(broj);

	cout << endl;
	return 0;
}