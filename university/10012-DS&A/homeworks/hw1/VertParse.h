#ifndef VERTPARSE_H_
#define VERTPARSE_H_
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <algorithm>

#include <SFML/Graphics.hpp>

#include "QuadStruct.h"


///////////////////////////////////////////
// returns just the QuadContainer (for now)
///////////////////////////////////////////
class VertParser {
public:
	bool loadVert(std::string filename);
	void Parse();
	std::vector<QuadStruct> get_container();

private:
	std::string m_VertFilename;
	std::stringstream m_buffer;
	std::vector<QuadStruct> quads;
};

#endif // VERTPARSE_H_
