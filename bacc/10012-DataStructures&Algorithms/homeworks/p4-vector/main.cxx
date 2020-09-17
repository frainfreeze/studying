#include <iostream>

class MojVektor {
	// Jednostavni vektor decimalnih brojeva. Kod povecanja
	// kapacitet je uvijek za 33% veći od dosadašnjeg.
	// Funcionalnost:
	//     a) Kreiranje praznog vektora
	//     b) Kreiranje vektora od n elemenata s ili bez zadane vrijednosti
	//     c) Umetanje elementa bilo gdje u vektor
	//     d) Dohvat veličine
	//     e) Dohvat elementa na mjestu i
private:
	double *brojevi;
	int s;
	int c;
	void grow();

public:
	MojVektor();

	explicit MojVektor(int n);
	MojVektor(int n, double elm);
	~MojVektor();

	int size();
	int capacity();
	void push_back(int value);
	void insert(int n, double element);
	double at(int i);
};

int main() {
	MojVektor v1;
	MojVektor v2(10);
	MojVektor v3(10, 2.312);

	std::cout << "v1 cap: " << v1.capacity() << std::endl
			  << "v3[1] == " << v2.at(1) << std::endl;

	v3.insert(2, 5.55);

	for (int i = 0; i < v3.size(); i++) {
		std::cout << v3.at(i) << " ";
	}

	std::cout << std::endl;
	return 0;
}

MojVektor::MojVektor()
{
	brojevi = new double[0];
	s = 0;
	c = 0;
}

MojVektor::MojVektor(int n)
{
	brojevi = new double[n];
	s = n;
	c = n;
}

MojVektor::MojVektor(int n, double elm)
{
	brojevi = new double[n];
	s = c = n;
	for (int i = 0; i < n; i++)
	{
		brojevi[i] = elm;
	}
}

MojVektor::~MojVektor()
{
	delete[] brojevi;
}

int MojVektor::size()
{
	return s;
}

int MojVektor::capacity()
{
	return c;
}

void MojVektor::push_back(int value) {
	if (c == s) {
		grow();
	}
	brojevi[s++] = value;
}

void MojVektor::insert(int n, double element)
{
	if (c == s) {
		grow();
	}

	s++;

	auto *novi = new double[c];

	int counter = 0;

	for (int i = 0; i < s; i++) {
		if (i == n) {
			novi[i] = element;
			counter = ++i;
			break;
		}
		novi[i] = brojevi[i];
	}


	for (int i = counter; i < s; i++) {
		novi[i] = brojevi[(--counter)++];
	}

	delete[] brojevi;
	brojevi = novi;

}

double MojVektor::at(int i)
{
	return brojevi[i];
}

void MojVektor::grow() {
	c = static_cast<int>(c * 1.33);
	auto * novi = new double[c];

	for (int i = 0; i < s; i++) {
		novi[i] = brojevi[i];
	}

	delete[] brojevi;
	brojevi = novi;
}