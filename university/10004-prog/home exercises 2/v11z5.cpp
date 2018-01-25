#include <iostream>
#include <vector>
#include <string>
using namespace std;

void IspisPolja(int* polje, int brojElemenata);
void PrebaciBrojeveuDrugoPoljeuObrnutomRedoslijedu(int* polje, int* polje2, int brojElemenata);


void main()
{
	int poljeBrojeva[5] = { 1, 2, 3, 4, 5 };
	int poljeObrnutihBrojeva[5];

	IspisPolja(poljeBrojeva, 5);
	PrebaciBrojeveuDrugoPoljeuObrnutomRedoslijedu(poljeBrojeva, poljeObrnutihBrojeva, 5);
	IspisPolja(poljeObrnutihBrojeva, 5);
}

void IspisPolja(int* polje, int brojElemenata)
{
	for (int i = 0; i < brojElemenata; i++)
	{
		cout << polje[i] << endl;
	}
	cout << endl;
}

void PrebaciBrojeveuDrugoPoljeuObrnutomRedoslijedu(int* polje, int* polje2, int brojElemenata)
{
	int j = brojElemenata - 1;
	for (int i = 0; i < brojElemenata; i++)
	{
		polje2[j] = polje[i];
		j--;
	}
}