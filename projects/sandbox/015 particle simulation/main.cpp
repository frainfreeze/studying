#include <iostream>
#include <random>
#include <cstring>
#include <cmath>
#include "/home/frain/tmp/build/SDL/include/SDL.h"

using namespace std;
//g++ -o main main.cpp `sdl2-config --cflags --libs` && ./main
//TODO: gui(nuclear? roll my own?), blur effect, speed & count toggle...

/**
* Log an SDL error with some error message to the output stream of our choice
* @param os The output stream to write the message to
* @param msg The error message to write, format will be msg error: SDL_GetError()
*/	
void logSDLError(std::ostream &os, const std::string &msg){
    os << msg << " error: " << SDL_GetError() << std::endl;
}

class Screen {
public:
    const static int SCREEN_WIDTH = 800;
    const static int SCREEN_HEIGHT = 600;
    Screen();
    bool init();
    void update();
    void setPixel(int x, int y, Uint8 red, Uint8 green, Uint8 blue);
    bool processEvents();
    void close();
    void clear_screen();

private:
    SDL_Window *m_window;
    SDL_Renderer *m_renderer;
    SDL_Texture *m_texture;
    Uint32 *m_buffer;
};

//struct has public members by default
struct Particle {
	Particle();
	void update(int interval);

	double m_x;
	double m_y;
	double m_speed;
	double m_direction;
};

class Swarm {
public:
	const static int NPARTICLES = 5000;
	Swarm();
	virtual ~Swarm();
	const Particle * const getParticles() { return m_pParticles; };
    void update(int elapsed);

private:
	Particle * m_pParticles;
        int last_time;
};

int main() {
    srand(time(nullptr));

    Screen screen;

    if(screen.init() == false) {
        cout << "Error initialising SDL." << endl;
    }

    Swarm swarm;


    while (true) {
        int elapsed = SDL_GetTicks();       

        // Update particles
        swarm.update(elapsed);
        screen.clear_screen(); //toggle me

        // Draw particles
        unsigned char green = (unsigned char)((1 + sin(elapsed * 0.001)) * 128);
        unsigned char red = (unsigned char)((1 + sin(elapsed * 0.002)) * 128);
        unsigned char blue = (unsigned char)((1 + sin(elapsed * 0.003)) * 128);

        const Particle * const pParticles = swarm.getParticles();   

		for (int i = 0; i < Swarm::NPARTICLES; i++) {
			Particle particle = pParticles[i];
			int x = (particle.m_x + 1) * Screen::SCREEN_WIDTH / 2;
			int y = particle.m_y * Screen::SCREEN_WIDTH / 2 + Screen::SCREEN_HEIGHT/2;
			screen.setPixel(x, y, red, green, blue);
		}

        // Draw the screen
        screen.update();

        // Check for messages/events
        if(screen.processEvents() == false) {
            break;
        }
    }

    screen.close();
    return 0;
}

//screen implementation
Screen::Screen() :
        m_window(NULL), m_renderer(NULL), 
        m_texture(NULL), m_buffer(NULL) 
        {}

bool Screen::init() {
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        return false;
    }

    m_window = SDL_CreateWindow("Particle Fire Explosion",
    SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH,
            SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

    if (m_window == NULL) {
            logSDLError(std::cout, "CreateWindow");
        SDL_Quit();
        return false;
    }

    m_renderer = SDL_CreateRenderer(m_window, -1, SDL_RENDERER_PRESENTVSYNC);
    m_texture = SDL_CreateTexture(m_renderer, SDL_PIXELFORMAT_RGBA8888,
            SDL_TEXTUREACCESS_STATIC, SCREEN_WIDTH, SCREEN_HEIGHT);

    if (m_renderer == NULL) {
        logSDLError(std::cout, "Could not create renderer");
        SDL_DestroyWindow(m_window);
        SDL_Quit();
        return false;
    }

    if (m_texture == NULL) {
        logSDLError(std::cout, "Could not create texture");
        SDL_DestroyRenderer(m_renderer);
        SDL_DestroyWindow(m_window);
        SDL_Quit();
        return false;
    }

    m_buffer = new Uint32[SCREEN_WIDTH * SCREEN_HEIGHT];
    memset(m_buffer, 0, SCREEN_WIDTH * SCREEN_HEIGHT * sizeof(Uint32));

    return true;
}

void Screen::setPixel(int x, int y, Uint8 red, Uint8 green, Uint8 blue) {
    // inefficient check but prevents segfaults
	if(x < 0 || x >= SCREEN_WIDTH || y < 0 || y >= SCREEN_HEIGHT) {
		return;
	}

    Uint32 color = 0;

    color += red;
    color <<= 8;
    color += green;
    color <<= 8;
    color += blue;
    color <<= 8;
    color += 0xFF;

    m_buffer[(y * SCREEN_WIDTH) + x] = color;
}

void Screen::update() {
    SDL_UpdateTexture(m_texture, NULL, m_buffer, SCREEN_WIDTH * sizeof(Uint32));
    SDL_RenderClear(m_renderer);
    SDL_RenderCopy(m_renderer, m_texture, NULL, NULL);
    SDL_RenderPresent(m_renderer);
}

bool Screen::processEvents() {
    SDL_Event event;

    while (SDL_PollEvent(&event)) {
        if (event.type == SDL_QUIT) {
            return false;
        }
    }
    return true;
}

void Screen::clear_screen(){
    memset(m_buffer, 0, SCREEN_WIDTH * SCREEN_HEIGHT * sizeof(Uint32));
}

void Screen::close() {
    delete[] m_buffer;
    SDL_DestroyRenderer(m_renderer);
    SDL_DestroyTexture(m_texture);
    SDL_DestroyWindow(m_window);
    SDL_Quit();
}

//particle implementation
Particle::Particle(): m_x(0), m_y(0) {
	m_direction = (2 * M_PI * rand())/RAND_MAX;
	m_speed = (0.000005 * rand())/RAND_MAX;
}

void Particle::update(int interval) {
	double xspeed = m_speed * cos(m_direction);
	double yspeed = m_speed * sin(m_direction);

	m_x += xspeed * interval;
	m_y += yspeed * interval;
}

//swam implementation
Swarm::Swarm() {
	m_pParticles = new Particle[NPARTICLES];
    last_time = 0;
}

Swarm::~Swarm() {
	delete [] m_pParticles;
}

void Swarm::update(int elapsed) {
    int interval = elapsed - last_time;

    for(int i = 0; i<Swarm::NPARTICLES; i++)
        m_pParticles[i].update(interval);

    last_time = interval;
}