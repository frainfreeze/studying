#include <iostream>
#include <string>
#include <utility>
#include <fstream>
using namespace std;

struct Auto{
    string marka;
};

int main() {
    Auto test[4];

    ifstream infile("a.txt");
    if(!infile){
        cout << "pogreska pri citanju" << endl;
        return 1;
    }

    string line;
    int brojac = 0;
    while(getline(infile, line)){
        test[brojac].marka = line;
        brojac++;
    }

    for (auto &i : test) {
        cout << i.marka << endl;
    }
    
    return 0;
}
