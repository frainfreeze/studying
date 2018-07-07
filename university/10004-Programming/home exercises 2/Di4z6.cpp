#include <iostream>
#include <string>

using namespace std;

//paziti na redoslijed, prvo kreiramo struct Profesor jer ga struct Kolegij koristi
struct Profesor {
    string ime;
    string prezime;
};

struct Kolegij {
    string naziv;
    int ects_bodovi;
    bool obavezan;
    Profesor profesor;
};



int main() {

    //1.nacin - sve inicijaliziramo na jednom mjestu bez da inicijaliziramo Profesora
    Kolegij k;
    k.naziv = "Programiranje";
    k.ects_bodovi = 20;
    k.obavezan = true;
    k.profesor.ime = "Goran";
    k.profesor.prezime = "Djambic";

    string obavezan;
    if (k.obavezan) {
        obavezan = "je obavezan";
    }
    else {
        obavezan = "nije obavezan";
    }

    cout << k.naziv << " predaje " << k.profesor.ime << " " << k.profesor.prezime << ", kolegij nosi " << k.ects_bodovi << " bodova te " << obavezan << endl;

    //2.nacin - Profesora inicijaliziramo zasebno
    Kolegij k1;
    Profesor p;
    p.ime = "Milan";
    p.prezime = "Korac";
    k1.profesor = p;

    k1.naziv = "Elektronika";
    k1.ects_bodovi = 20;
    k1.obavezan = true;

    if (k1.obavezan) {
        obavezan = "je obavezan";
    }
    else {
        obavezan = "nije obavezan";
    }

    cout << k1.naziv << " predaje " << k1.profesor.ime << " " << k1.profesor.prezime << ", kolegij nosi " << k1.ects_bodovi << " bodova te " << obavezan << endl;

    return 0;
}