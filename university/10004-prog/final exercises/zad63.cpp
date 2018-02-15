#include <iostream>
#include <string>
using namespace std;

void prepis(char polje1[], char polje2[], int velicina){
    int brojac = velicina-1;
    for (size_t i = 0; i < velicina; i++){
        polje2[brojac] = polje1[i];
        brojac--;
    }
}

int main() {
    int velicina = 5;
    char polje1[5] = {'a','+','b','=','c'};
    char polje2[5];

    prepis(polje1,polje2,velicina);

    for (size_t i = 0; i < velicina; i++){
        cout << polje2[i] << " ";
    }
    cout << endl;

    return 0;
}
