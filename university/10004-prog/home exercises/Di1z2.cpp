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

    int manji;
    int veci;

    if (a < b)
    {
        manji = a;
        veci = b;
    }
    else 
    {
        manji = b;
        veci = a;
    }

    //for (int i = manji; i <= veci; i++)
    //{
    //    cout << i << " ";
    //}
    //cout << endl;
    
    //for (int i = veci; i >= manji; i--)
    //{
    //    cout << i << " ";
    //}
    //cout << endl;

    //for (int i = veci; i >= manji; i-=2)
    //{
    //    cout << i << " ";
    //}
    //cout << endl;
    
    int i = veci;
    while (i >= manji)
    {
        cout << i << " ";
        i -= 2;
    }
    cout << endl;



    return 0;
}