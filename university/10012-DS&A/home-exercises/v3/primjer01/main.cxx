#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <ctime>
#include <chrono>

#include "Tocka.h"

using namespace std;

Tocka* prepare_array(int n) {
	Tocka* tocke = new Tocka[n];
	for (int i = 0; i < n; i++) {
		cout << "Unos " << i + 1 << ". tocke: " << "\n";
		cout << "x:";
		int x;
		cin >> x;
		cout << "y:";
		int y;
		cin >> y;
		tocke[i].init(x, y);
	}
	return tocke;
}

int generate_random(int min, int max) 
{
    return rand() % (max - min + 1) + min;
}

int main() 
{
	Tocka t;
	cout << "Udaljenost default: " << t.distance() << "\n";
	t.init(100, 90);	
	cout << "Udaljenost nakon inicijalizacije: " << t.distance() << "\n";

	int n = 5; 
	Tocka* tocke = prepare_array(n);
	for (int i = 0; i < n; i++) {
		cout << "Udaljenost tocke " << i + 1 << " od ishodista: " << tocke[i].distance() << "\n";
	}
	delete[] tocke;

	srand(time(nullptr));
    int min = 100;
    int max = 200;
    int rnd = generate_random(100, 200);
	cout << "Slucajni broj: " << rnd << "\n";

	auto begin = chrono::high_resolution_clock::now();
	for (int i = 1; i <= 10; i++) {
		for (int j = 1; j <= 10; j++) {
			cout << "\t" << i * j;
		}
		cout << "\n";
	}

	auto end = chrono::high_resolution_clock::now();
	cout  << "Potrebno vrijeme: " 
		  << chrono::duration_cast<chrono::milliseconds>(end - begin).count()
		  << " ms" << "\n";

	ifstream in("Broj_znanstvenika_na_milijun_stanovnika.csv");
	if (!in) {
		cout << "Nije moguce pristupiti datoteci" << endl;
		return 1;
	}

	//ignoriranje prva 2. reda i hvatanje 3. reda -> Albania
	string line;
	for (int i = 0; i < 3; i++) {
		getline(in, line);
	}

	in.close();

	// stringstream za parsing stringa
	stringstream ss(line);
	string br_znanstvenika;

	//ignoriranje prve 4. kolone i hvatanje 5. kolone -> 2008
	for (int i = 0; i < 5; i++) {
		getline(ss, br_znanstvenika, ';');
	}

	stringstream converter;
	converter << br_znanstvenika;
	int broj;
	if (converter >> broj) {
		cout << "Broj znanstvenika u Albaniji za 2008. godinu: " << broj << "\n";
	} else {
		cout << "Broj znanstvenika u Albaniji za 2008. godinu nije definiran"<< "\n";
	}

	return 0;
}