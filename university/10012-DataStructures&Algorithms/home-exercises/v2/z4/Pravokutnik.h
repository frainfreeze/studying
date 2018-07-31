#pragma once
#include <string>

class Pravokutnik {
public:
	Pravokutnik(int sirina, int visina);
	std::string shape(char edge, char content, bool draw_content) const;
	
private:
	int sirina;
	int visina;
};

