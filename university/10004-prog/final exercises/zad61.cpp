#include <iostream>
#include <fstream>
using namespace std;

int magik(int poljebr[], int brBra){
    int suma = 0;
    for(int i = 0; i < brBra; i++){
        if(poljebr[i]%5==0){
            suma++;
        }
    }
    return suma;
}

int main() {
    int poljeBr[] = {5,10,15,12,14};
    cout << "djeljivih sa 5: " << magik(poljeBr,5) << endl;
    return 0;
}
