#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main()
{
	int broj;
	vector <int> prostiBrojevi;
	bool prostBroj = false;

	//korisnik mora unijeti broj veci od nula
	do
	{
		cout << "Unesite broj: ";
		cin >> broj;

		if(broj < 10)
			cout << "Morate unijeti broj veci ili jednak 10!" << endl;
	} while (broj < 10);	

	//provjeriti sve brojeve iz raspona [10-broj] da li su prosti
	for (int i = 10; i < broj; i++)
	{
		//broj djelim s brojevima [2-(broj-1)]
		for (int j = 2; j < i; j++)
		{
			if(i % j == 0){
				prostBroj = false;
				break;
			}
			else
				prostBroj = true;
		}
		if(prostBroj)
			prostiBrojevi.push_back(i);
	}

	cout << endl << "Ispis prostih brojeva: ";
	for (int i = 0; i < prostiBrojevi.size(); i++)
	{
		if(i != prostiBrojevi.size()-1)
			cout << prostiBrojevi[i] << ", ";
		else
			cout << prostiBrojevi[i] << ".";
	}

	cout << endl << endl;
	return 0;
}