#include <iostream>

using namespace std;

void ispisi_kvadrat(int broj) {
    //iteriramo po retcima
    for (int redak = 1; redak <= broj; redak++) {
        //iteriramo po stupcima
        for (int stupac = 0; stupac <= broj; stupac++) {
            //u ovisnosti jesmo li presli pola redaka, definiramo ispis
            if (redak <= broj / 2) {
                cout << "*";
            }
            else {
                cout << "#";
            }
        }
        //skok u novi red
        cout << endl;
    }
}

int main() {

    int broj;
    do {
        cout << "Unesite paran broj, molim: ";
        cin >> broj;
        //dok je uneseni broj neparan vrti se u petlji
    } while (broj % 2 != 0);

    ispisi_kvadrat(broj);

    return 0;
}