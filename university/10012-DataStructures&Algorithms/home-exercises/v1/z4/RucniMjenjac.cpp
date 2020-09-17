#include "RucniMjenjac.h"

RucniMjenjac::RucniMjenjac()
{
	this->stanje = 0;
}

void RucniMjenjac::prema_gore()
{
	if (stanje < 5) {
		stanje++;
	}
}

void RucniMjenjac::prema_dolje()
{
	if (stanje > 0) {
		stanje--;
	}
}

string RucniMjenjac::to_string()
{
	switch (stanje) {
	case 0: return "*zzz*";
	case 1: return "R";
	case 2: return "Rr";
	case 3: return "Rrr";
	case 4: return "Brrrm";
	case 5: return "Brrrrrrrrrrrrrrrrrm!";
	default: return "";
	}
}

