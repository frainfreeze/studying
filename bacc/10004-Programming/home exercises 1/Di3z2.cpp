#include <iostream>

using namespace std;

bool neparan(int broj) {
    //ako broj nije paran, vracamo true
    if (broj % 2 != 0) {
        return true;
    }
    //vracamo false jer je paran
    return false;
}

int main() {
    cout << "Unesite molim jedan broj: ";
    int broj;
    cin >> broj;
    //poziv metode i stavljanje povratne vrijednosti u varijablu
    bool je_neparan = neparan(broj);
    if (je_neparan) {
        cout << "Broj " << broj << " je neparan" << endl;
    }
    else {
        cout << "Broj " << broj << " nije neparan" << endl;
    }
    return 0;
}