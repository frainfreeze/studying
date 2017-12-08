#include <iostream>
#include <cmath>

using namespace std;

int main() {

    int a;
    cout << "Unesite prvi broj:";
    cin >> a;

    int b;
    cout << "Unesite drugi broj:";
    cin >> b;

    cout << a << " kvadrat: " << pow(a, 2) << endl;
    cout << a << " korijen: " << sqrt(a) << endl;

    cout << b << " kvadrat: " << pow(b, 2) << endl;
    cout << b << " korijen: " << sqrt(b) << endl;

    int veci;
    if (a > b) 
    {
        veci = a;
        cout << "od brojeva " << a << " i " << b << ", veci je " << veci << endl;
    }
    else if (b > a)
    {
        veci = b;
        cout << "od brojeva " << a << " i " << b << ", veci je " << veci << endl;
    }
    else 
    {
        cout << "brojevi su isti!" << endl;
    }

    return 0;
}