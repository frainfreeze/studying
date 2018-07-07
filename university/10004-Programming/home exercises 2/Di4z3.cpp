#include <iostream>

using namespace std;

struct PravokutanTrokut {
    int a;
    int b;
    int c;
};

//zadovoljava li trokut pitagorin poucak?
//a = 3, b = 4, c = 5 -> tocan
bool pravilno_unesen(PravokutanTrokut pt) {
    if (pt.a * pt.a + pt.b * pt.b == pt.c * pt.c) {
        return true;
    }
    return false;
}

int main() {

    PravokutanTrokut pt;
    cout << "Unesite molim stranicu a:";
    cin >> pt.a;
    cout << "Unesite molim stranicu b:";
    cin >> pt.b;
    cout << "Unesite molim stranicu c:";
    cin >> pt.c;

    bool je_pravilno_unesen = pravilno_unesen(pt);

    if (je_pravilno_unesen) {
        cout << "Stranice su pravilno unesene." << endl;
    }
    else {
        cout << "Stranice nisu pravilno unesene." << endl;
    }


}