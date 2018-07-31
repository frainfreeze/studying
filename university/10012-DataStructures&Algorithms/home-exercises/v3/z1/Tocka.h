#pragma once

class Tocka {
public:
	Tocka();
	void init(int x, int y);
	double distance();
	int get_x();
	int get_y();
private:
	int x;
	int y;
};
