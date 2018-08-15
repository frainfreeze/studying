#include <iostream>
#include <fstream>
#include <string> 

using namespace std;

struct Data {
	char name[100];
	int age;
	double height;
};

int main() {
	string filename = "data.bin";
	Data data = { "Frodo", 120, 0.8 };
	/*
	 data.name = "Frodo";
	 data.age = 120;
	 data.height = 0.8;
	*/

	//write bin file
	ofstream output;
	output.open(filename);

	if (!output.is_open()) {
		cout << "Could not create " << filename << endl;
	}

	output.write((char *) &data, sizeof(data)); //reinterpret_cast<char *>(&data), sizeof(data)

	if (!output) {
		cout << "Could not write data to file " << filename << endl;
	}

	output.close();

	//read bin file
	ifstream input;
	input.open(filename);

	if (!input.is_open()) {
		cout << "Could not read " << filename << endl;
	}

	Data inputData;
	input.read((char *) &inputData, sizeof(data));

	if (!input) {
		cout << "Could not read data from file " << filename << endl;
	}

	input.close();

	//print
	cout << inputData.name << ": " << inputData.age << ": " << inputData.height << endl;

	return 0;
}