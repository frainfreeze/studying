#include <iostream>
#include <ctime>

#include "funkcije_za_sortiranje.h"
#include "StopWatch.h"

using namespace std;

int generate_random(int min, int max) 
{
    return rand() % (max - min + 1) + min;
}

int* prepare_array(int n) 
{
    srand(time(nullptr));
	int* polje = new int[n];
	for (int i = 0; i < n; i++) {
		polje[i] = generate_random(1, 1000);
	}
	return polje;
}

int* copy_array(int *polje, int n) 
{
	int* kopija = new int[n];
	for (int i = 0; i < n; i++) {
		kopija[i] = polje[i];
	}
	return kopija;
}

int main() 
{
	int n = 1000;
	int* brojevi1 = prepare_array(n);
	int* brojevi2 = copy_array(brojevi1, n);
	StopWatch timer;

	timer.start();
    quick_sort(brojevi1, n);
	timer.stop();

	cout << "Quick sort: "
		 << timer.get_elapsed_microseconds()
		 << " us" << endl;


	timer.start();
	bubble_sort(brojevi2, n);
	timer.stop();

	cout << "Bubble sort: "
		 << timer.get_elapsed_microseconds()
		 << " us" << endl;

	delete[] brojevi1;
	delete[] brojevi2;

	return 0;
}