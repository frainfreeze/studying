#include <iostream>
#include <string>

using namespace std;

int main() {

    //problem nastaje kada zelimo unijeti broj i potom string 
    //znaci unasamo broj iz konzole koji hvatamo s >> operatorom
    //nakon sto je broj unesen, u cin (console input streamu) je zaostao enter (\n) koji smo lupili
    //ukoliko ne napravimo cin.ignore(), poziv getline(cin, s) ce pokupiti enter
    int godina;
    string ime;

    cout << "Unesite godinu studija:" << endl;
    //hvatamo broj
    cin >> godina;
    //cistimo console input od entera - pokusajte zakomentirati sljedecu liniju i istestirajte
    cin.ignore();

    cout << "Unesite ime studenta:" << endl;
    //cin >> ime -> ne vrijedi jer cita samo do razmaka!
    //hvatamo string pomocu getline metode
    getline(cin, ime);

    cout << "ime studenta: " << ime << endl;
    cout << "godina studija: " << godina << endl;

    return 0;
}