#include "AssetManager.h"

AssetManager * AssetManager::sInstance = nullptr;

AssetManager::AssetManager() {
	// allow only one asset manager to exist, otherwise throw exception
	assert(sInstance == nullptr);
	sInstance = this;
}

sf::Texture & AssetManager::GetTexture(std::string const & filename) {
	auto& textMap = sInstance->m_Textures;

	// see if texture is loaded already...
	auto pairFound = textMap.find(filename);
	// ...if yes return texture
	if (pairFound != textMap.end())
		return pairFound->second;
	//else load texture and return it
	else {
		auto& texture = textMap[filename];
		texture.loadFromFile(filename);
		return texture;
	}
}