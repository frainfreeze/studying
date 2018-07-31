#pragma once

#include <string>

using namespace std;

class RucniMjenjac {
public:
	RucniMjenjac();
	void prema_gore();
	void prema_dolje();
	string to_string();
	
private:
	int stanje;
};

