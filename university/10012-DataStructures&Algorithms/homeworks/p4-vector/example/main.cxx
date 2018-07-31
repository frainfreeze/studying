#include <iostream>
#include <initializer_list>

class MojVektor {
// Jednostavni vektor cijelih brojeva. Kod povecanja
// kapacitet je uvijek za 50% veći od dosadašnjeg. 
// Funcionalnost:
//     a) Kreiranje vektora i njegova inicijalizacija pomoću liste
//     b) Dohvat veličine i kapaciteta
//     c) Umetanje elementa na kraj
//     d) Dohvat elementa na mjestu i 

private:
    int* brojevi;
    int s;
    int c;
    void grow();

public:
    MojVektor(std::initializer_list<int> il);
    ~MojVektor();
    int size();
    int capacity();
    void push_back(int value);
    int at(int i);
};

int main(){
    MojVektor mv = { 11, 22, 33, 44, 55 };
    mv.push_back(66);
    mv.push_back(77);
    mv.push_back(88);
    mv.push_back(99);

    std::cout << "s=" << mv.size() << ", c=" << mv.capacity() << std::endl;

    for (int i = 0; i < mv.size(); ++i) {
        std::cout << mv.at(i) << std::endl;
    }   
}

MojVektor::MojVektor(std::initializer_list<int> il) 
{
    brojevi = new int[il.size()];
    int i = 0;
    for (auto it = il.begin(); it != il.end(); ++it) {
        brojevi[i++] = *it;
    }
    s = il.size();
    c = il.size();
}

MojVektor::~MojVektor() 
{
    delete[] brojevi;
}

int MojVektor::size() 
{
    return s;
}

int MojVektor::capacity() 
{
    return c;
}

void MojVektor::push_back(int value) {
    if (c == s) {
        grow();
    }
    brojevi[s++] = value;
}

int MojVektor::at(int i) 
{
    return brojevi[i];
}

void MojVektor::grow() {
    c = c * 1.5;
    int* novi = new int[c];

    for (int i = 0; i < s; i++) {
        novi[i] = brojevi[i];
    }

    delete[] brojevi;
    brojevi = novi;
}