#ifndef VERTQUAD_H_
#define VERTQUAD_H_
#include <SFML/Graphics.hpp>

#include "QuadStruct.h"

class VertQuad : public sf::Drawable, public sf::Transformable {
public:
	bool load(std::vector<QuadStruct> & bar);

private:
	void draw(sf::RenderTarget& target, sf::RenderStates states) const override {
		target.draw(m_vertices, states);	// draw the vertex array
	}
	sf::VertexArray m_vertices;
};

#endif // VERTQUAD_H_