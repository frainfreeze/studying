#ifndef VERTQUAD_H
#define VERTQUAD_H

#include <SFML/Graphics.hpp>

#include "QuadStruct.h"

class VertQuad : public sf::Drawable, public sf::Transformable {
public:
	bool load(QuadContainer & bar);

private:
	virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const {
		// draw the vertex array
		target.draw(m_vertices, states);
	}
	sf::VertexArray m_vertices;
};

#endif // VERTQUAD_H