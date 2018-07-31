#pragma once
#include <string>

class student {
public:
	void init(std::string ime, std::string prezime, int god_rodjenja);
	std::string to_string();
	
private:
	std::string ime;
	std::string prezime;
	int god_rodjenja;
};