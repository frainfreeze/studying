#include <iostream>
#include <string>
using namespace std;

struct Kvadar
{
	double a;
	double b;
	double c;
};
double Povrsina(Kvadar k)
{
	return 2 * (k.a*k.b + k.a*k.c + k.b*k.c);
}
double Volumen(Kvadar k)
{
	return k.a * k.b * k.c;
}
double DuljinaProstorneDijagonale(Kvadar k)
{
	return sqrt(pow(k.a, 2) + pow(k.c, 2) + pow(k.c, 2));
}

void main()
{
	Kvadar kvadar;
	cout << "Unesite stranicu A: ";
	cin >> kvadar.a;

	cout << "Unesite stranicu B: ";
		cin >> kvadar.b;

	cout << "Unesite stranicu C: ";
		cin >> kvadar.c;

	cout << endl;
	cout << "VOLUMEN: " << Volumen(kvadar) << endl;
	cout << "OPLOSJE: " << Povrsina(kvadar) << endl;
	cout << "PROSTORNA DIJAGONALA: " << DuljinaProstorneDijagonale(kvadar) << endl;

}