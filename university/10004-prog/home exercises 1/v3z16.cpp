#include <iostream>
#include <string>
using namespace std;


int main(){
	int brojac,prirodniBroj;

    do{
		cout << "Upisi prirodni broj: ";        
		cin >> prirodniBroj;
	}
	while (prirodniBroj < 0);
		
	cout << "Djelitelji broja " << prirodniBroj << " su: ";

    for (brojac = 1; brojac <= prirodniBroj; brojac++)
    {
		if(prirodniBroj % brojac == 0)
			cout << brojac << " ";
    }
	cout<<endl;
	return 0;
}
