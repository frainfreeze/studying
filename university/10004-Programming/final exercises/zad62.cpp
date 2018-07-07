#include <iostream>
#include <string>
using namespace std;

int main() {
    int br = 0;
    cin >> br;
    string* polje = new string[br];

    string line;
    for (int i = 0; i <= br; i++) {
        getline(cin, line);
        polje[i] = line;
    }

    cout << endl;

    for (int i = br; i >= 0; i--) {
        cout << polje[i] << endl;
    }

    delete[] polje;

    return 0;
}
