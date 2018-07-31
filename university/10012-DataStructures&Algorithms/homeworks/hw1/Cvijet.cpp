#include "Cvijet.h"

Cvijet::Cvijet(sf::RenderWindow* window) : mainWindow(window) {
	flowerSize = sf::Vector2f(0.2f, 0.2f);
	flowerPos = sf::Vector2f(105, 200);
	
	// background
	if ((!texture1.loadFromFile("data\\sprites\\background.jpg")) || 
		(!texture2.loadFromFile("data\\sprites\\background_tree.png")))
		std::cerr << "Failed to load background pictures." << std::endl;

	// load model
	if (!spaz.loadVert("data\\models\\simple-cvijet.vert"))
		std::cout << "Failed to load model file.\n";

	// get the container
	bar = spaz.get_container();

	// anim
	numFrames = 8;
	animDuration = .95f;

	//animation resources
	if ((!cloak1Tex.loadFromFile("data\\sprites\\cloack5.png")) ||
		(!cloak2Tex.loadFromFile("data\\sprites\\cloack4.png")) ||
		(!cloak3Tex.loadFromFile("data\\sprites\\cloack3.png")) ||
		(!cloak4Tex.loadFromFile("data\\sprites\\cloack1.png")) ||
		(!cloak5Tex.loadFromFile("data\\sprites\\cloack0.png"))) {
		std::cerr << "Failed to load animation pictures." << std::endl;
	}

	// load  distortionMap for shader
	if (!distortionMap.loadFromFile("data\\sprites\\distortion_map.png"))
		std::cerr << "Failed to load distortion map." << std::endl;

	distortionMap.setRepeated(true);
	distortionMap.setSmooth(true);

	// load and setup shaders
	if (!shader.loadFromFile("data\\shaders\\heat_shader.vs", "data\\shaders\\heat_shader.fs"))
		std::cerr << "Failed to load shader, exiting..." << std::endl;

	shader.setUniform("currentTexture", sf::Shader::CurrentTexture);
	shader.setUniform("distortionMapTexture", distortionMap);
	distortionFactor = .007f; // Shader, Fragment Shader
	riseFactor = .05f;
}

const void Cvijet::draw(const sf::Time& deltaTime) {
	// load flower image
	sf::Texture flowerTexture;
	if (!flowerTexture.loadFromFile("data\\sprites\\flower.jpg")) {
		// we can live without the texture, but warn the user
		std::cerr << "Error loading texture (image)" << std::endl;
	}
	sf::Sprite flowerSprite(flowerTexture);
	flowerSprite.setPosition(flowerPos);
	flowerSprite.setScale(flowerSize);

	// load shapes
	VertQuad body;
	if (!body.load(bar))
		std::cerr << "Error while loadig quads!" << std::endl;

	// load background 
	sf::Sprite background(texture1);
	sf::Sprite backgroundTree(texture2);

	//acumulate time with each frame
	elapsedTime += deltaTime;
	const float timeAsSeconds = elapsedTime.asSeconds();

	// get current animation frame
	const int animFrame = static_cast<int>((timeAsSeconds / animDuration)*numFrames) % numFrames;
	
	// render animation frame depending on frame...
	switch (animFrame) {
	case 1: cloak.setTexture(cloak1Tex); break;
	case 2: cloak.setTexture(cloak2Tex); break;
	case 3: cloak.setTexture(cloak3Tex); break;
	case 4: cloak.setTexture(cloak4Tex); break;
	case 5: cloak.setTexture(cloak5Tex); break;
	case 6: cloak.setTexture(cloak4Tex); break;
	case 7: cloak.setTexture(cloak3Tex); break;
	case 8: cloak.setTexture(cloak2Tex); break;
	default: break;
	}
	
	// using heatwave shader to simulate wind
	shader.setUniform("time", clock.getElapsedTime().asSeconds());
	shader.setUniform("distortionFactor", distortionFactor);
	shader.setUniform("riseFactor", riseFactor);
	
	// draw
	mainWindow->draw(background);
	mainWindow->draw(backgroundTree, &shader);
	mainWindow->draw(body);
	mainWindow->draw(flowerSprite);
	mainWindow->draw(cloak);
}

void Cvijet::setPos(float x, float y) {
	flowerPos += sf::Vector2f(x, y);
}