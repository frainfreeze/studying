#include <iostream>
#include <fstream>
using namespace std;

#pragma pack(push, 1)

struct Person {
	char name[50];
	int age;
	double weight;
};

#pragma pack(pop)

// https://stackoverflow.com/questions/4306186/structure-padding-and-packing
// http://www.catb.org/esr/structure-packing/
// https://en.wikipedia.org/wiki/Data_structure_alignment
int main() {

	cout << sizeof(Person) << endl;

	return 0;
}