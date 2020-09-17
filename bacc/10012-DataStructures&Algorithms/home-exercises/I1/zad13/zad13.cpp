#include <iostream>
#include <sstream>
#include <string>
#include <fstream>
using namespace std;

template<typename T>
T convert(string &s) {
	T result;
	stringstream converter(s);
	converter >> result;
	return result;
}

int main()
{
    ifstream in("LakeHuron.csv");
    if(!in)
        return -1;

    string l1,l2,l3;
    int vLvlMaxYear;
    double vLvlMax = 0;
    getline(in, l1);

    // "2",1876,581.86
    while(getline(in,l1,',')&&getline(in,l2,',')&&getline(in,l3)){
		int year = convert<int>(l2);
		double level = convert<double>(l3);
 
        if(level>vLvlMax){
            vLvlMaxYear = year;
            vLvlMax = level;
        }
    }

    // koje  godine  je  vodostaj  rijeke  Huron  (Michigan)  bio najviši
    cout << "Najvisi vodostaj je bio " << vLvlMaxYear << " godine " 
    << " i iznosio je " << vLvlMax << "m." << endl;
    
    in.close();
    return 0;
}