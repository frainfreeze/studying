#include <iostream>
using namespace std;

int Suma()
{
	int suma = 0;
	for(int i = 100; i <= 200; i++){
		suma +=i;
	}
	return suma;
}

int main()
{
	cout << "Suma brojeva izmedju 100 i 200 je: " << Suma();		
	cout << endl;
	return 0;
}