#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

struct Automobil {
	string imeAuta;
	string regAuta;
};

void bazaIO(vector<Automobil>& automobili, int foo=0){
    if(foo==0){
        ifstream myfile("automobili.txt");
        if (myfile.is_open()) {
            Automobil noviAutomobil;
            while (getline(myfile, noviAutomobil.imeAuta, '|') && getline(myfile, noviAutomobil.regAuta)) automobili.push_back(noviAutomobil);
		} else cout << "nemogu otvoriti bazu.\n";
    } else {
        ofstream myfile("automobili.txt");
        if (myfile.is_open()) {
            for (unsigned int i = 0; i<automobili.size(); i++) myfile << automobili[i].imeAuta << "|" << automobili[i].regAuta << "\n";
        } else cout << "nemogu otvoriti bazu.\n";
    }
}

void ispis(int foo, vector<Automobil>& automobili) {
	for (unsigned int i = 0; i<automobili.size(); i++) cout << automobili[i].imeAuta << "(" << automobili[i].regAuta << ")\n";
	if (foo) {
		cout << "Povratak na glavni izbornik\n";
		cin.ignore();
	}
}

int izbornik(vector<Automobil>& automobili) {
	system("CLS");
	cout << "Unesite izbor:\n1. Ispis automobila\n2. Unos automobila\n3. Brisanje automobila\n4. Izlaz\n";

	int temp;
	string tempAuto, tempAuto1;
	cin >> temp;
	cin.ignore();

    if(temp==1) ispis(1, automobili);
    else if(temp==2){
        cout << "Unos automobila\nUnesite vrstu: ";
        getline(cin, tempAuto);
        cout << "Unesite registraciju: ";
        getline(cin, tempAuto1);
        automobili.push_back(Automobil{tempAuto, tempAuto1});
        cout << "Automobil uspjesno unesen\nPovratak na glavni izbornik\n";
        cin.ignore();
    } else if(temp==3){
        ispis(0, automobili);
        cout << "Unesite vrstu automobila za obrisati:";
        getline(cin, tempAuto);
        automobili.erase(remove_if(automobili.begin(), automobili.end(), [&](Automobil const & automobil) {return automobil.imeAuta == tempAuto; }), automobili.end());
        cout << "Povratak na glavni izbornik\n";
        cin.ignore();
    } else if(temp==4){
        bazaIO(automobili,1);
        return -1;
    } else cout << "Neispravan odabir.\n";
}

int main() {
	vector<Automobil> automobili;
	bazaIO(automobili);
	while (izbornik(automobili) != -1);
	return 0;
}