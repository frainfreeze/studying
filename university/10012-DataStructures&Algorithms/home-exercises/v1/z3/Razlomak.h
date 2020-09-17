#pragma once

#include <string>

using namespace std;

class Razlomak {
public:
	Razlomak(int brojnik, int nazivnik);
	void multiply(int x);
	string to_string();

private:
	int brojnik;
	int nazivnik;
};

