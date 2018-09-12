#ifndef QUADSTRUCT_H
#define QUADSTRUCT_H

#include <SFML/Graphics.hpp>
#include <vector>

struct QuadStruct{
    sf::Vector2f a = sf::Vector2f();
    sf::Vector2f b = sf::Vector2f();
    sf::Vector2f c = sf::Vector2f();
    sf::Vector2f d = sf::Vector2f();
};

struct QuadContainer{
    int numQuads;
    std::vector<QuadStruct> quads;
};

#endif // QUADSTRUCT_H
