#include <iostream>
#include <cmath>
#include "pravokutnik.h"
using namespace std;

void Pravokutnik::inicijaliziraj(int s, int v) {
    sirina = s;
    visina = v;
}

void Pravokutnik::mnozi_skalarom(int skalar) {
    sirina *= skalar;
    visina *= skalar;
}

int Pravokutnik::povrsina() { return sirina * visina; }

int Pravokutnik::opseg() { return 2 * sirina + 2 * visina; }

double Pravokutnik::dijagonala() { return sqrt(sirina*sirina + visina*visina); }

void Pravokutnik::iscrtaj() {
    for (int i = 0; i < visina; i++) {
        for (int j = 0; j < sirina; j++) {
            if (i == 0 || i == visina - 1) cout << "*";
            else {
                if (j == 0 || j == sirina - 1) cout << "*";
                else cout << ' ';
                }
            }
        cout << endl;
    }
}
