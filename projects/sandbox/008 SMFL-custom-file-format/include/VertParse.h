#ifndef VERTPARSER_H
#define VERTPARSER_H
#include <map>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <algorithm>

#include <SFML/Graphics.hpp>

#include <QuadStruct.h>

///////////////////////////////////////////
// returns just the QuadContainer (for now)
///////////////////////////////////////////
class VertParser{
public:
    bool loadVert(std::string filename);
    void Parse();
    QuadContainer get_container();

private:
    std::string m_VertFilename;
    std::stringstream m_buffer;
    QuadContainer quadCotainer;
};

#endif // VERTPARSER_H
