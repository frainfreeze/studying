#include <iostream>
#include <string>
using namespace std;

void UcitajBrojeve(int* poljeBrojeva, int velicinaPolja)
{
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << "Unesite " << (i + 1) << ". broj: ";
		cin >> poljeBrojeva[i];
	}
}

void IspisiPolje(int* poljeBrojeva, int velicinaPolja)
{
	cout << "ISPIS NORMALNIM REDOSLIJEDOM" << endl;
	for (int i = 0; i < velicinaPolja; i++)
	{
		cout << poljeBrojeva[i] << endl;
	}

	cout << "ISPIS OBRNUTIM REDOSLIJEDOM" << endl;
	for (int i = velicinaPolja - 1; i >= 0; i--)
	{
		cout << poljeBrojeva[i] << endl;
	}
}

int GetSumaBrojevaPolja(int* poljeBrojeva, int velicinaPolja)
{
	int zbroj = 0;
	for (int i = 0; i < velicinaPolja; i++)
	{
		zbroj += poljeBrojeva[i];
	}
	return zbroj;
}

double GetAtritmetickaSredina(int* poljeBrojeva, int velicinaPolja)
{	
	return GetSumaBrojevaPolja(poljeBrojeva, velicinaPolja)/5.0;
}

void DefinirajMinMaxElementePolja(int* poljeBrojeva, int velicinaPolja, int* min, int* max)
{
	*min = poljeBrojeva[0];
	*max = poljeBrojeva[0];

	for (int i = 0; i < velicinaPolja; i++)
	{
		if (poljeBrojeva[i] < *min)
			*min = poljeBrojeva[i];
		if (poljeBrojeva[i] > *max)
			*max = poljeBrojeva[i];
	}
}


void main()
{
	int poljeBrojeva[5];
	int min, max;

	UcitajBrojeve(poljeBrojeva, 5);
	cout << endl;

	IspisiPolje(poljeBrojeva, 5);
	cout << endl;

	cout << "SUMA: " << GetSumaBrojevaPolja(poljeBrojeva, 5) << endl;
	cout << "ARITMETICKA SREDINA: " << GetAtritmetickaSredina(poljeBrojeva, 5) << endl;

	DefinirajMinMaxElementePolja(poljeBrojeva, 5, &min, &max);
	cout << "MIN: " << min << endl;
	cout << "MAX: " << max << endl;
}