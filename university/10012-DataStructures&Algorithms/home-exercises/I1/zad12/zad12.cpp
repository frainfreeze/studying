// zad A) stack, queue, singly-linked list, doubly-linked list
// zad B)
#include <iostream>
#include <ctime>
#include <chrono>
using namespace std;
using namespace std::chrono;

int main()
{
    int brojevi[10000];
    long long int temp = 0;
    srand(time(0));

    auto t1 = high_resolution_clock::now();
    //Generirajte 10.000 slučajnih cijelih brojeva između 1 i 5. 
    for (int i = 0; i < 10000; ++i) {
        brojevi[i] = (rand() % 5) + 1;
    }

    // Nakon toga, izračunajte i ispišite prosjek svih tih brojeva.
    for (int i = 0; i < 10000; ++i) {
        temp+=brojevi[i];
    }
    cout << "prosjek brojeva je: " << temp/10000 << endl;
    auto t2 = high_resolution_clock::now();

    // Potrebno je i izračunati i ispisati ukupno trajanje 
    // cijelog posla (od generiranja do izračuna prosjeka).

    nanoseconds ns = duration_cast<nanoseconds>(t2 - t1); 
    long long trajanje = ns.count();
    cout << "tajanje: " << trajanje << " ns" << endl;
}