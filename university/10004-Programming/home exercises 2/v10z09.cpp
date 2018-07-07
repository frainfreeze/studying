#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Stozac
{
private:
	double PI = 3.14159;

public:
	//polumjer baze
	double r;
	//visina
	double h;

	double GetVolumen() {
		return (pow(r, 2) * PI * h) / 3;
	}

	double GetOplosje() {
		//Izvodnica
		double s = sqrt(pow(h, 2) + pow(r, 2));
		return r * PI * (r + s);
	}
};


void main() {
	Stozac stozac;

	cout << "Polumjer stozca: ";
	cin >> stozac.r;

	cout << "Visina stozca: ";
	cin >> stozac.h;

	cout << endl;
	cout << "Volumen: " << stozac.GetVolumen() << endl;
	cout << "Oplosje: " << stozac.GetOplosje() << endl;

}