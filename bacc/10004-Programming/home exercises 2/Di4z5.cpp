#include <iostream>
#include <string>

using namespace std;

struct Trkac {
    string ime;
    string prezime;
    double prolazno_vrijeme[3];

};


int main() {

    Trkac t;
    t.ime = "Ivica";
    t.prezime = "Olic";
    //polju u strukturi prilazimo na standardan nacin
    t.prolazno_vrijeme[0] = 11.4;
    t.prolazno_vrijeme[1] = 11.2;
    t.prolazno_vrijeme[2] = 10.9;

    double ukupno_vrijeme = 0;
    //po polju u strukturi iteriramo na standardan nacin
    for (int i = 0; i<3; i++) {
        ukupno_vrijeme += t.prolazno_vrijeme[i];
    }

    double srednje_vrijeme = ukupno_vrijeme / 3;

    cout << "Srednje prolazno vrijeme za trkaca: " << t.ime << " " << t.prezime << " je " << srednje_vrijeme << "." << endl;

    return 0;

}