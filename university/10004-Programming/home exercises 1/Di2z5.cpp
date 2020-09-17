#include <iostream>
#include <vector>

using namespace std;

int main() {

    vector<int> brojevi;
    char dalje;
    do
    {
        int broj;
        cout << "Unesite broj:";
        cin >> broj;
        brojevi.push_back(broj);

        cout << "Dalje(d/n)?";
        cin >> dalje;
    } while (dalje == 'd');

    double suma = 0;
    int min = brojevi[0];
    int max = brojevi[0];
    for (int i = 0; i < brojevi.size(); i++)
    {
        if (brojevi[i] < min) {
            min = brojevi[i];
        }
        if (brojevi[i] > max) {
            max = brojevi[i];
        }
        suma += brojevi[i];
    }
    cout << "min: " << min << endl;
    cout << "max: " << max << endl;
    cout << "suma: " << suma << endl;
    cout << "artm. sredina: " << suma / brojevi.size() << endl;

    return 0;
}