#include <sstream>
#include "Student.h"

using namespace std;

void student::init(string ime, string prezime, int god_rodjenja) 
{
	this->ime = ime;
	this->prezime = prezime;
	this->god_rodjenja = god_rodjenja;
}

string student::to_string() 
{
	stringstream ss;
	ss << ime << ", " << prezime << ", " << god_rodjenja;
	return ss.str();
}

