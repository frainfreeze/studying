#include <iostream>

using namespace std;

int zbroj_brojeva(int manji, int veci) {
    //zamjena ako je manji veci od veceg
    if (manji > veci) {
        int temp = manji;
        manji = veci;
        veci = temp;
    }
    int zbroj = 0;
    for (int i = manji; i<=veci; i++) {
        zbroj += i;
    }
    return zbroj;
}

int main() {
    int broj1;
    int broj2;
    cout << "Unesite molim prvi broj: ";
    cin >> broj1;
    cout << "Unesite molim drugi broj: ";
    cin >> broj2;
    //poziv metode i automatski ispis
    cout << zbroj_brojeva(broj1, broj2) << endl;
    return 0;
}