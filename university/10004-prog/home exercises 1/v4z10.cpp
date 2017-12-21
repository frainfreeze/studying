#include <iostream>
#include <ctime>
using namespace std;


int main()
{
	srand(time(0));

	int bubajn[45];
	int odigraniBrojevi[7];
	int broj;
	int temp;

	cout << "LOTO 7/45" << endl << endl;

	//Odigraj brojeve
	for (int i = 0; i < 7; i++)
	{
		//Osiguraj da korisnik unese broj iz raspona 1-45
		bool brojJeVecOdigran;
		do
		{
			cout << "Odigrajte " << i + 1 << ". broj: ";
			cin >> broj;

			//Osiguraj da 2x ne odigra isti broj
			for (int j = 0; j < 7; j++)
			{
				brojJeVecOdigran = false;	
				if (odigraniBrojevi[j] == broj) {
					brojJeVecOdigran = true;
					break;
				}
			}
		} while (broj < 1 || broj > 45 || brojJeVecOdigran);
		odigraniBrojevi[i] = broj;
	}

	//Sortiraj odigrane brojeve
	for (int i = 0; i < 7; i++)
	{
		for (int j = 0; j < (7 - 1); j++)
		{
			if (odigraniBrojevi[j] > odigraniBrojevi[j + 1])
			{
				temp = odigraniBrojevi[j + 1];
				odigraniBrojevi[j + 1] = odigraniBrojevi[j];
				odigraniBrojevi[j] = temp;
			}
		}
	}

	//Ubaci brojeve u bubanj
	for (int i = 0; i < 45; i++)
	{
		bubajn[i] = i + 1;
	}

	//Izvuci 7 brojeva
	int izvuceniBrojevi[7];
	for (int i = 0; i < 7; i++)
	{
		bool brojJeVecOdabran;
		int slucajniBroj;

		//osiguraj da se ne izvuèe 2x isti broj
		do
		{
			brojJeVecOdabran = false;
			slucajniBroj = rand() % 46;
			for (int i = 0; i < 7; i++)
			{
				if (izvuceniBrojevi[i] == slucajniBroj) {
					brojJeVecOdabran = true;
					break;
				}
			}
		} while (brojJeVecOdabran);
		izvuceniBrojevi[i] = slucajniBroj;
	}

	//Sortiraj izvuèene brojeve
	for (int i = 0; i < 7; i++)
	{
		for (int j = 0; j < (7 - 1); j++)
		{
			if (izvuceniBrojevi[j] > izvuceniBrojevi[j + 1])
			{
				temp = izvuceniBrojevi[j + 1];
				izvuceniBrojevi[j + 1] = izvuceniBrojevi[j];
				izvuceniBrojevi[j] = temp;
			}
		}
	}

	//Prikaži izvuèene brojeve
	cout << endl;
	cout << "IZVUCENI BROJEVI: ";
	for (int i = 0; i < 7; i++)
	{
		cout << izvuceniBrojevi[i] << "\t";
	}

	//Prikaži odigrane brojeve
	cout << endl;
	cout << "ODIGRANI BROJEVI: ";
	for (int i = 0; i < 7; i++)
	{
		cout << odigraniBrojevi[i] << "\t";
	}

	cout << endl << endl;
	cout << "DOBITNI BROJEVI: ";

	//Prikaži dobitne brojeve
	int brojPogodaka = 0;
	for (int i = 0; i < 7; i++)
	{
		//Izvuceni broj usporedi s odigranim brojevima
		for (int j = 0; j < 7; j++)
		{
			if (izvuceniBrojevi[i] == odigraniBrojevi[j]) {
				brojPogodaka++;				
				cout << izvuceniBrojevi[i] << "\t";
			}
		}
	}
	
	cout << endl;
	cout << "BROJ POGODAKA: " << brojPogodaka;
	cout << endl << endl << endl;
	return 0;
}
