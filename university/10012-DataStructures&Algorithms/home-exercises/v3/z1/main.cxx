#include <iostream>
#include <iomanip>
#include <fstream>
#include <chrono>

#include "Tocka.h"

using namespace std;

Tocka* prepare_array(int n)
{
	Tocka* tocke = new Tocka[n];

	for (int i = 0; i < n; i++){
		tocke[i].init(i, i);
	}

	return tocke;
}

int main() 
{
	ofstream out("udaljenosti.txt");
	if (!out){
		cout << "bljet" << endl;
		return 1;
	}

	int n = 1000;
	n = 10000;
	n = 20000;
	n = 100000;

	Tocka *tocke = prepare_array(n);

	auto begin = chrono::high_resolution_clock::now();
    // http://en.cppreference.com/w/cpp/io/manip/setprecision
	for (int i = 0; i < n; i++) {
		double d = tocke[i].distance();
		out << "d(" << tocke[i].get_x() << ", " << tocke[i].get_y() << ") = " << setprecision(12) << d << endl;
	}

	auto end = chrono::high_resolution_clock::now();

	out.close();
	delete[] tocke;

	cout << "Potrebno vrijeme: "
		 << chrono::duration_cast<chrono::milliseconds>(end - begin).count()
	 	 << " ms" << endl;

	return 0;
}