#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Film {
    string naziv;
    int trajanje;
    string redatelj;
    string glavni_glumac;
    string tip;

};

//funkcija vraca film
Film kreiraj_film(string naziv, string tip, string redatelj, string glavni_glumac, int trajanje) {
    Film f;
    f.naziv = naziv;
    f.tip = tip;
    f.redatelj = redatelj;
    f.glavni_glumac = glavni_glumac;
    f.trajanje = trajanje;
    return f;
}


int main() {

    vector<Film> filmovi;
    int dalje;
    //unos filmova
    do {
        string naziv;
        cout << "Unesite molim naziv: ";
        getline(cin, naziv);
        cout << "Unesite molim tip: ";
        string tip;
        getline(cin, tip);
        cout << "Unesite molim redatelja: ";
        string redatelj;
        getline(cin, redatelj);
        cout << "Unesite molim glavnog glumca: ";
        string glavni_glumac;
        getline(cin, glavni_glumac);
        cout << "Unesite molim trajanje u minutama: ";
        int trajanje;
        cin >> trajanje;
        //kreiramo film pozivom funkcije
        Film f = kreiraj_film(naziv, tip, redatelj, glavni_glumac, trajanje);
        filmovi.push_back(f);
        cout << "Dalje (0/1): ";
        cin >> dalje;
        cin.get();
    } while (dalje != 0);

    cout << endl;
    //ispis filmova
    for (int i = 0; i<filmovi.size(); i++) {
        cout << filmovi[i].naziv << ", " << filmovi[i].tip << ", " << filmovi[i].redatelj << ", " << filmovi[i].glavni_glumac << ", " << filmovi[i].trajanje << endl;
    }

    return 0;

}