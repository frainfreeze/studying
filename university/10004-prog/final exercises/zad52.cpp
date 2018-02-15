#include <iostream>
#include <string>
#include <utility>
#include <fstream>
using namespace std;

struct Adresa{
    string ulica;
    int kucBr;
    int postBr;
};

void makeAdresa(Adresa poljeadd[], string ulica, int kucbr, int postbr, int brAdd){
    poljeadd[brAdd] = {std::move(ulica), kucbr, postbr};
}

int main() {
    Adresa test[3];
    makeAdresa(test,"test ulica",1,10000,0);
    makeAdresa(test,"draga",3,51522,1);
    makeAdresa(test,"baska",23,51523,2);
    
    ofstream outfile("b.txt");
    if(!outfile){
        cout << "pogreska pri otvaranju dat" << endl;
        return 1;
    }

    for (auto &i : test) {
        outfile << i.ulica << "," << i.kucBr << "," << i.postBr << endl;
    }
    
    return 0;
}
