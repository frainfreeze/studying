#include <iostream>
#include <string>
#include <ctime>

using namespace std;

int main() {

    srand(time(0));
    int max = 10;
    int min = 5;
    int duljina = rand() % (max - min + 1) + min;

    string rijec;
    do
    {
        cout << "Unesite rijec od " << duljina << " slova:";
        getline(cin, rijec);
    } while (rijec.length() != duljina);

    for (int i = rijec.length() - 1; i >=0 ; i--) {
        cout << rijec[i];
    }
    cout << endl;

    return 0;
}