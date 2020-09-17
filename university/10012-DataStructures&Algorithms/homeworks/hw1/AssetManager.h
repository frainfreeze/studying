#ifndef ASSETMANAGER_H_
#define ASSETMANAGER_H_
#include <SFML/Graphics.hpp>
#include <assert.h>
#include <map>

///////////////////////////////////////////////////
// AssetManager holds a map of textures and has an
// interface to access them. 
///////////////////////////////////////////////////
class AssetManager {
public:
	AssetManager();
	static sf::Texture& GetTexture(std::string const& filename);

private:
	std::map<std::string, sf::Texture>m_Textures;

	//AssetManager is singleton
	static AssetManager* sInstance;
};

#endif // ASSETMANAGER_H_