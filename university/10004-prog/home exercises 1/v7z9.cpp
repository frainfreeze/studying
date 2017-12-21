#include <iostream>
#include <string>
using namespace std;


void Ispis(int n)
{
	if (n == 0) {
		return;
	}
	Ispis(n / 10);
	cout << n % 10 << " ";
}


int main()
{   
	int n;
    cout << "Unesi prirodan broj  "; 
    cin >> n;
    
	Ispis(n);
	   
	cout << endl;
	return 0;
}