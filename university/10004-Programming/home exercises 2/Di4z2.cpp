#include <iostream>
#include <string>

using namespace std;

struct Zaposlenik {
    string ime;
    string prezime;
    bool stalni_zaposlenik;
    double placa;
};

Zaposlenik unos() {
    Zaposlenik z;
    cout << "Unesite molim ime:";
    getline(cin, z.ime);
    cout << "Unesite molim prezime:";
    getline(cin, z.prezime);
    cout << "Unesite molim placu:";
    cin >> z.placa;
    cout << "Unesite molim je li stalni zaposlenik 0(nije)/1(je):";
    int stalni;
    cin >> stalni;
    if (stalni == 0) {
        z.stalni_zaposlenik = false;
    }
    else {
        z.stalni_zaposlenik = true;
    }
    return z;
}

int main() {

    //deklaracija polja od 3 zaposlenika
    Zaposlenik polje[3];
    //unos podataka
    for (int i = 0; i<3; i++) {
        cout << i + 1 << ". Zaposlenik. " << endl;
        //obavezno jer se vracamo gore gdje ponovno unosimo string - paziti!
        polje[i] = unos();
        cin.get();
    }

    double suma_placa = 0;

    //iteriranje po polju 
    int i = 0;
    while (i<3) {
        //ispit uvjeta
        if (polje[i].stalni_zaposlenik) {
            suma_placa += polje[i].placa;
        }
        i++;
    }

    cout << "Suma placa stalnih zaposlenika je " << suma_placa << endl;

    return 0;
}