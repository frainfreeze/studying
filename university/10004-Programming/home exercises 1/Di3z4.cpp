#include <iostream>

using namespace std;

int min(int a, int b, int c) {
    if (a < b && a < c) {
        return a;
    }
    else if (b < a && b < c) {
        return b;
    }
    return c;
}

int max(int a, int b, int c) {
    if (a > b && a > c) {
        return a;
    }
    else if (b > a && b > c) {
        return b;
    }
    return c;
}
int main() {
    int broj1;
    int broj2;
    int broj3;
    cout << "Unesite molim prvi broj: ";
    cin >> broj1;
    cout << "Unesite molim drugi broj: ";
    cin >> broj3;
    cout << "Unesite molim treci broj: ";
    cin >> broj2;
    //poziv metoda
    cout << "min:" << min(broj1, broj2, broj3) << endl;
    cout << "max:" << max(broj1, broj2, broj3) << endl;
    return 0;
}