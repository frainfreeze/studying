#include "VertParse.h"

bool VertParser::loadVert(std::string filename) {
	if (filename.empty())
		return false;

	std::ifstream inFile(filename);

	if (!inFile.is_open())
		return false;

	m_buffer << inFile.rdbuf();

	// https://stackoverflow.com/questions/3106110/what-are-move-semantics
	// Save the filename for the reload
	m_VertFilename = std::move(filename);

	Parse();
	return true;
}

void VertParser::Parse() {
	std::string line;
	std::string line2;

	QuadStruct foo;
	int quadCounter = 0;

	std::istringstream s(m_buffer.str());

	while (std::getline(s, line)) {

		// Ignore empty and comment lines
		if (line.empty() || line[0] == '#')
			continue;

		std::string segment;
		std::string segment2;
		std::istringstream ss(line);

		while (std::getline(ss, segment, '=') && std::getline(ss, segment2)) {
			// Trim the white space
			std::stringstream trimmer;
			trimmer << segment;
			segment.clear();
			trimmer >> segment;

			trimmer.str(std::string());
			trimmer.clear();

			trimmer << segment2;
			segment2.clear();
			trimmer >> segment2;

			//convert everything into lowercase
			std::transform(segment.begin(), segment.end(), segment.begin(), ::tolower);
			std::transform(segment2.begin(), segment2.end(), segment2.begin(), ::tolower);

			// get quads
			if (segment.find("quad.") == 0) quadCounter++;

			switch (quadCounter) {
			case 1: foo.a.x = std::stof(segment2); break;
			case 2: foo.a.y = std::stof(segment2); break;
			case 3: foo.b.x = std::stof(segment2); break;
			case 4: foo.b.y = std::stof(segment2); break;
			case 5: foo.c.x = std::stof(segment2); break;
			case 6: foo.c.y = std::stof(segment2); break;
			case 7: foo.d.x = std::stof(segment2); break;
			case 8: foo.d.y = std::stof(segment2); break;
			default: break;
			}
		}
		if (quadCounter >= 8) {
			quadCotainer.quads.push_back(foo);
			quadCounter = 0;
		}
	}
}

QuadContainer VertParser::get_container() { return quadCotainer; }