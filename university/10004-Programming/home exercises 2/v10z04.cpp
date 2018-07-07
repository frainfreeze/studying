#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Tocka
{
	float x,y;
};
struct Pravokutnik
{
	Tocka GornjaLijeva;
	Tocka DonjaDesna;
};
Tocka GetSredistePravokutnika(Pravokutnik p)
{
	Tocka sredisnjaTocka;
	sredisnjaTocka.x = (p.GornjaLijeva.x + p.DonjaDesna.x) / 2;
	sredisnjaTocka.y = (p.GornjaLijeva.y + p.DonjaDesna.y) / 2;
	return sredisnjaTocka;
}

void main()
{
	Pravokutnik p;
	//x1, y1
	cout << "X koordinata gornje lijeve tocke:";
	cin >> p.GornjaLijeva.x;
	cout << "Y koordinata gornje lijeve tocke:";
	cin >> p.GornjaLijeva.y;
	cout << endl;

	//x2, y2
	cout << "X koordinata donje desne tocke:";
	cin >> p.DonjaDesna.x;
	cout << "Y koordinata donje desne tocke:";
	cin >> p.DonjaDesna.y;
	cout << endl;

	cout << "KOORDINATA SREDISNE TOCKE PRAVOKUTNIKA" << endl;
	cout << "X: " << GetSredistePravokutnika(p).x << endl;
	cout << "Y: " << GetSredistePravokutnika(p).y << endl;
}