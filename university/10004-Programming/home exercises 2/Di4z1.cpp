#include <iostream>
#include <string>

using namespace std;

struct Automobil {
    string naziv;
    string tip;
    int broj_vrata;
    bool obiteljski;
    double potrosnja;
};
int main() {

    Automobil automobil;
    automobil.naziv = "Volkswagen";
    automobil.tip = "Polo";
    automobil.broj_vrata = 5;
    automobil.obiteljski = true;
    automobil.potrosnja = 7.2;

    //koristit cemo pomocnu varijablu
    string obiteljski;
    if (automobil.obiteljski) {
        obiteljski = "je obiteljski";
    }
    else {
        obiteljski = "nije obiteljski";
    }

    cout << automobil.naziv << " - " << automobil.tip << " sa " << automobil.broj_vrata << " vrata " << obiteljski << " i trosi " << automobil.potrosnja << " litara" << endl;

    return 0;
}