#ifndef TOCKA_H_
#define TOCKA_H_

#include <string>

using namespace std;

class Tocka {
public:
	Tocka(int x, int y);
	int get_x();
	void set_x(int x);
	int get_y();
	void set_y(int x);
	Tocka();
	string to_string();
	double distance();
private:
	int x;
	int y;
};

#endif // TOCKA_H_