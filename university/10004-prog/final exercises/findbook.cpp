#include <iostream>
#include <string>
#include <utility>

using namespace std;

struct Knjiga{
    string Autor;
    string Naslov;
    int brStr;
};

void makeBook(Knjiga poljeKnjiga[], string naslov, string autor, int brstr, int brKnige){
    poljeKnjiga[brKnige] = {std::move(naslov), std::move(autor),brstr};
}

int main() {
    Knjiga test[3];
    makeBook(test, "ivan mazuranic", "pjesme", 100, 0);
    makeBook(test, "ivan mazuranic", "pjesme2", 101, 1);
    makeBook(test, "ivan mazuranic", "pjesme3", 102, 2);

    int temp;
    char temp2;
    bool dalje = true;
    do{
        cout << "unesite broj str knjige:101 ";
        cin >> temp;
        bool found = false;

        for (auto &i : test) {
            if( temp== i.brStr){
                found = true;
                cout << i.Naslov << endl;
                break;
            }
        }

        if(!found){
            cout << "knjiga nije pronadena";
        }
        cout << "nastaviti? d/n";
        cin >> temp2;
        if (temp2=='n') dalje = false;
    } while (dalje);

    return 0;
}
