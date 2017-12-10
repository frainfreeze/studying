#include <iostream>
#include <string>

using namespace std;

int main() {

    cout << "Unesite recenicu:";
    string recenica;
    getline(cin, recenica);

    cout << "Unesite znak:";
    char znak;
    cin >> znak;

    int brojac = 0;
    for (int i = 0; i < recenica.length(); i++) {
        if (recenica[i] == znak) {
            brojac++;
        }
    }
    cout << "Znak " << znak << " se  pojavljuje " << brojac << " puta" << endl;

    return 0;
}