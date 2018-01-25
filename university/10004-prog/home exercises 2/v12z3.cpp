#include <iostream>
#include <string>
using namespace std;

int GetBrojParnih(int* poljeBrojeva, int velicinaPolja)
{
	int brojParnih = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (poljeBrojeva[i] % 2 == 0)
			brojParnih++;
	}
	return brojParnih;
}
int GetBrojNeparnih(int* poljeBrojeva, int velicinaPolja)
{
	int brojNeparnih = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (poljeBrojeva[i] % 2 != 0)
			brojNeparnih++;
	}
	return brojNeparnih;
}
bool JeProst(int broj)
{
	for (int i = 2; i <= broj/2; i++)
	{
		if (broj % i == 0)
			return false;
	}
	if(broj==1){return false;}
	return true;
}
int GetBrojProstihBrojeva(int* poljeBrojeva, int velicinaPolja)
{
	int brojProstih = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		if (JeProst(poljeBrojeva[i]))
			brojProstih++;
	}
	return brojProstih;
}

void main(){
	int poljeBrojeva[10] = {1,2,3,4,5,6,7,8,9,10};
	cout << "Broj parnih brojeva: " << GetBrojParnih(poljeBrojeva, 10) << endl;
	cout << "Broj neparnih brojeva: " << GetBrojNeparnih(poljeBrojeva, 10) << endl;
	cout << "Broj prostih brojeva: " << GetBrojProstihBrojeva(poljeBrojeva, 10) << endl;
}