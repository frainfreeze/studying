#include <iostream>
#include <sstream>
#include <string>
#include <fstream>

using namespace std;

void write_string(string line, ofstream &out) 
{
    short length = line.length();
    out.write((char*)&length, sizeof(length));
    out.write(line.c_str(), length);
}

string read_string(short length, ifstream &in) 
{
    char* temp = new char[length];
    in.read(temp, length);
    string s(temp, length);
    delete[] temp;
    return s;
}


int main() 
{
	ifstream is("Broj_znanstvenika_na_milijun_stanovnika.csv");
	ofstream os("nazivi_drzava.dat", ios_base::binary);

	if (!is || !os) {
		cout << "Unable to open file" << endl;
		return 1;
	}

	string line;
    //preskocimo zaglavlje
	getline(is, line);
	while (getline(is, line)) {
		stringstream ss(line);
		string naziv;
		getline(ss, naziv, ';');
		//cout << naziv << endl;
        write_string(naziv, os);
    }
	os.close();
	is.close();

    ifstream bin("nazivi_drzava.dat", ios_base::binary);
    if (!bin) {
        cout << "Nije moguce pristupiti datoteci" << endl;
        return 1;
    }
    while (true) 
	{
        short length;
        if (!bin.read((char*)&length, sizeof(length))) {
            break;
        }
        string naziv = read_string(length, bin);
        cout << naziv << endl;
    }

    bin.close();
	return 0;
}