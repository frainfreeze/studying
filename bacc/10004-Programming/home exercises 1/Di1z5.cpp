#include <iostream>

using namespace std;

int main() {

    bool dalje;
    do
    {
        int broj;
        cout << "Unesite broj:";
        cin >> broj;
        if (broj % 5 == 0) {
            cout << broj << " je dijeljiv s 5" << endl;
        }
        cout << "Zelite li dalje (1-da, 0-ne)";
        cin >> dalje;
    //} while (dalje == true);
    } while (dalje);

    return 0;
}