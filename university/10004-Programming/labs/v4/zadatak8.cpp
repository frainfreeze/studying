#include <iostream>
#include<ctime>
using namespace std;

/*
Zadatak 8.Napisite program koji ce u polju od 20 elemenata pronaci najveci i najmanji element. 
Ispisite te elemente. Polje popunite slucajnim brojevima.

#include<ctime>// potrebno zaglavlje
srand(time(0));
rand()%100;// generira slucajni broj izmedu 0 i 99.

*/

int main()
{
	srand(time(0)); //seed
	int polje[20];

	//popunimo polje
	for (int i = 0; i < 20; i++)
	{
		polje[i] = rand() % 100;
	}

	//definiramo najmanji i najveci element
	int najmanji = polje[0]; 
	int najveci = polje[0];

	for (int i = 1; i< 20; i++)
	{
		if (polje[i] > najveci) {
			najveci = polje[i];
		}
		if (polje[i] < najmanji) {
			najmanji = polje[i];
		}
	}

	cout << endl << "Najveci broj u polju je: " << najveci;
	cout << endl << "Najmanji broj u polju je: " << najmanji << endl;
	return 0;
}