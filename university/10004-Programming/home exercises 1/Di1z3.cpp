#include <iostream>
#include <cmath>

using namespace std;

int main() {

    double a;
    cout << "Unesite prvi broj:";
    cin >> a;
    double b;
    cout << "Unesite drugi broj:";
    cin >> b;
    double c;
    cout << "Unesite treci broj:";
    cin >> c;

    char op;
    cout << "Unesite operaciju:";
    cin >> op;

    switch (op)
    {
    case '+':
        cout << a << op << b << op << c << "=" << a + b + c << endl;
        break;
    case '-':
        cout << a << op << b << op << c << "=" << a - b - c << endl;
        break;
    case '*':
        cout << a << op << b << op << c << "=" << a * b * c << endl;
        break;
    case '/':
        cout << a << op << b << op << c << "=" << a / b / c << endl;
        break;
    default:
        cout << "Kriva opreracija" << endl;
        break;
    }




    return 0;
}