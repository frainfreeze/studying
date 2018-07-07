#include <iostream>

using namespace std;

bool prost_broj(int broj) {
    //jedan je specijalan slucaj pa ga rijesavamo ovdje
    if (broj==1) {
        return false;
    }
    //sa 1 je svaki broj dijeljiv, pa vrtimo od 2 do broja (odosno do broja-1)
    //(svaki broj je dijeljiv sam sa sobom, ali nam uvjet osigurava da se to nece provjeravati)
    for (int i = 2; i<broj; i++) {
        //ako je broj dijeljiv sa trenutnim brojem vrati da nije prost
        if (broj%i == 0) {
            return false;
        }
    }
    //ako je sve brojeve prosao, znaci da je prost
    return true;
}

int main() {

    int broj;
    cout << "Unesite molim broj: ";
    cin >> broj;
    //poziv metode i spremanje povratne vrijednosti u varijablu
    bool prost = prost_broj(broj);
    if (prost) {
        cout << "Broj " << broj << " je prost broj" << endl;
    }
    else {
        cout << "Broj " << broj << " nije prost broj" << endl;
    }
    return 0;
}