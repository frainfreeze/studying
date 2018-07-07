#include <iostream>
#include <string>
using namespace std;

void prepis(char polje1[], char polje2[], int n) {
	int brojac = n-1;
	for (int i = 0; i < n; i++){
		polje2[i] = polje1[brojac];
		brojac--;
	}
}

int main() {
	char polje1[] = { 'a','+','b','=','c' };
	char polje2[5];

	prepis(polje1, polje2, 5);

	for (int i = 0; i < 5; i++){
		cout << polje2[i] << " ";
	}
	cout << endl;

	return 0;
}