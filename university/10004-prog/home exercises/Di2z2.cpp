#include <iostream>

using namespace std;

int main() {

    int polje[6];
    int n = sizeof(polje) / sizeof(int);
    for (int i = 0; i < n; i++) {
        cout << "Unesite " << i + 1 << ". broj:";
        cin >> polje[i];
    }

    int obrnuto[6];
    int index = 0;
    for (int i = n - 1; i >= 0; i--) {
        obrnuto[index] = polje[i];
        index++;
    }

    for (int i = 0; i < n; i++) {
        cout << obrnuto[i] << " ";
    }
    cout << endl;

    return 0;
}