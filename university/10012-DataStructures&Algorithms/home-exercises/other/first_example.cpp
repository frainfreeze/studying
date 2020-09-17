#include <iostream>
#include <cmath>
using namespace std;

class Pravokutnik {
private:
    int sirina;
    int visina;

public:
    void inicijaliziraj(int s, int v) {
        sirina = s;
        visina = v;
    }

    void mnozi_skalarom(int skalar) {
        sirina *= skalar;
        visina *= skalar;
    }

    int povrsina() { return sirina * visina; }

    int opseg() { return 2 * sirina + 2 * visina; }

    double dijagonala() { return sqrt(sirina*sirina + visina*visina); }

    void iscrtaj() {
        for (int i = 0; i < visina; i++) {
            for (int j = 0; j < sirina; j++) {
                if (i == 0 || i == visina - 1) cout << "*";
                else {
                    if (j == 0 || j == sirina - 1) cout << "*";
                    else cout << ' ';
                    }
                }
            cout << endl;
        }
    }
};

int main(){

    Pravokutnik p;
    p.inicijaliziraj(10, 5);
    cout << p.povrsina() << endl;
    cout << p.opseg() << endl;
    cout << p.dijagonala() << endl;
    p.iscrtaj();
    p.mnozi_skalarom(2);
    p.iscrtaj();

    return 0;
}
