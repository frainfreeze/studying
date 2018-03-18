#include "VertQuad.h"

bool VertQuad::load(QuadContainer & bar) {
	int numShapes = bar.quads.size();

	m_vertices.setPrimitiveType(sf::Quads);
	m_vertices.resize(numShapes * 4); // quad has 4 points!

	int counter = numShapes * 4; // start from back
	for (int i = 0; i < numShapes; i++) {
		sf::Vertex* quad = &m_vertices[counter -= 4];

		quad[0].position = bar.quads[i].a;
		quad[1].position = bar.quads[i].b;
		quad[2].position = bar.quads[i].c;
		quad[3].position = bar.quads[i].d;

		quad[0].color = sf::Color::Blue;
		quad[1].color = sf::Color::Blue;
		quad[2].color = sf::Color::Red;
		quad[3].color = sf::Color::Red;

	}
	return true;
}

//todo: use foreach(arrays as quad) { yield quad }
//it doesnt store in RAM
