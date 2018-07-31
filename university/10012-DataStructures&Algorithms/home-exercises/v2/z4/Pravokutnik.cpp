#include "Pravokutnik.h"

#include <sstream>

Pravokutnik::Pravokutnik(int sirina, int visina)
{
	if (sirina <= 0 || visina <= 0)  {
		throw std::exception("Pravokutnik mora imati stranice vece od 0");
	}
	this->sirina = sirina;
	this->visina = visina;
}

std::string Pravokutnik::shape(char edge, char content, bool draw_content) const
{	
	std::stringstream ss;
	for (int i = 0; i < visina; i++) {
		for (int j = 0; j < sirina; j++) {
			if (i == 0 || j == 0 || i == visina - 1 || j == sirina - 1) {
				ss << edge;
			}
			else {
				if (draw_content) {
					ss << content;
				}
				else {
					ss << " ";
				}
			}
		}
		ss << std::endl;
	}
	return ss.str();
}

