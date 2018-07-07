#include <iostream>

using namespace std;

int main() {

    bool dalje;
    int suma = 0;
    long umnozak = 1;
    int brojac = 0;
    do
    {
        int broj;
        cout << "Unesite broj:";
        cin >> broj;
        suma += broj;
        umnozak *= broj;
        brojac++;
        cout << "Zelite li dalje (1-da, 0-ne)";
        cin >> dalje;
    } while (dalje);

    cout << "Suma brojeva: " << suma << endl;
    cout << "Umnozak brojeva: " << umnozak << endl;
    cout << "Aritmeticka sredina brojeva: " << (double)suma / brojac << endl;

    return 0;
}