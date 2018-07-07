#include <iostream>
#include <fstream>
using namespace std;

int main() {
    ifstream infile("brojevi.txt");
    if(!infile){
        cout << "pogreska pri otvaranju dat" << endl;
        return 1;
    }
    ofstream outfile("djeljivis2.txt");
    if(!outfile){
        cout << "pogreska pri otvaranju dat" << endl;
        return 1;
    }
    ofstream outfile1("djeljivis3.txt");
    if(!outfile1){
        cout << "pogreska pri otvaranju dat" << endl;
        return 1;
    }

    int broj;
    while(infile>>broj){
        if(broj%2==0)
            outfile << broj << endl;
        else if (broj%3==0)
            outfile1 << broj << endl;
    }
    
    outfile.close();
    outfile1.close();
    infile.close();
    return 0;
}
