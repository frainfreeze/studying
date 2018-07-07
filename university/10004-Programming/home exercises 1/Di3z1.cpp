#include <iostream>

using namespace std;

int apsolutna_vrijednost(int broj) {
    //ako je broj manji od nula, vracamo vrijednost suprotnog predznaka
    if (broj<0) {
        return -broj;
    }
    //vracamo pozitivnu vrijednost
    return broj;
}

int main() {
    cout << "Unesite molim jedan broj: ";
    int broj;
    cin >> broj;
    //poziv metode i stavljanje povratne vrijednosti u varijablu
    int abs = apsolutna_vrijednost(broj);
    cout << "Apsolutna vrijednost od " << broj << " je " << abs << endl;
    return 0;
}

