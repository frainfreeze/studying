#include <iostream>
#include <string>
using namespace std;

int main(){
	int brojac,j,d,s,zbroj;
    cout << "Troznamenkasti brojevi ciji je zbroj znamenaka 5, a zadnja im je znamenka 0 su:" << endl;

    for(brojac = 100; brojac <= 999; brojac++)         
    {
        j = brojac % 10;
        d = (brojac / 10) % 10;
        s = brojac / 100;
        zbroj = j + d + s;

        if(zbroj == 5 && j==0)          
			cout<< brojac << "\n";   
    }
    cout << endl;
	return 0;
}
