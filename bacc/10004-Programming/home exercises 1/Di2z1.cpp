#include <iostream>

using namespace std;

int main() {

    int polje[] = { 1, 2, 3, 4, 5, 6 };
    int n = sizeof(polje) / sizeof(int);
    for (int i = 0; i < n; i++) {
        if (polje[i] % 2 == 0) {
            cout << polje[i] << " je paran" << endl;
        }
        else {
            cout << polje[i] << " je neparan" << endl;

        }
    }

    return 0;
}