#include <iostream>
#include <fstream>
#include <string>

using namespace std;

void read_file(const string &fname) 
{
	ifstream in(fname);
	if (!in)  {
        // visual studio specific!
		throw exception("Nije moguce pristupiti datoteci");
	}

	string line;
	
    while (getline(in, line))  {
		cout << line << endl;
	}
	
    in.close();
}


int main() 
{
	string fname;
	cout << "Unesite naziv datoteke:";
	getline(cin, fname);

	try {
		read_file(fname);
	}
	catch (const exception &e) {
		cout << "Pogreska:" << e.what() << endl;
		return 1;
	}

	return 0;
}