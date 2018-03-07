#include <iostream>
#include "pravokutnik.h"
using namespace std;

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
