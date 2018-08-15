#include <iostream>
#include <fstream>
#include <sstream>
using namespace std;

int main() {
    // Population UK: 64000000
    // Population France: 66400000
	string filename = "stats.txt";

	ifstream input;
	input.open(filename);

	if(!input.is_open()) {
		return 1;
	}

	while(input) {
		string line;

		getline(input, line, ':');

		int population;
		input >> population;

		// input.get();
		input >> ws;

		if(!input) {
			break;
		}

		cout << "'" << line << "'" << " -- '" << population << "'" << endl;
	}

	input.close();

	return 0;
}