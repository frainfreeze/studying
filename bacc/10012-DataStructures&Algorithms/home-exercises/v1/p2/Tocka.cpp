#include <string>
#include <cmath>
#include <sstream>

using namespace std;

namespace tocka {

class Tocka {
public:
	Tocka(int x, int y) 
	{
		set_x(x);
		set_y(y);
	}
	int get_x() 
	{
		return x;
	}
	void set_x(int x) 
	{
		if (x < 0){
			x = 0;
		}
		this->x = x;
	}
	int get_y() 
	{
		return y;
	}
	void set_y(int y) 
	{
		if (y < 0){
			y = 0;
		}
		this->y = y;
	}
	Tocka() 
	{
		set_x(0);
		set_y(0);
	}
	string to_string() 
	{
		stringstream ss;
		ss << "t(" << x << ", " << y << ")";
		return ss.str();
	}
	double distance() 
	{
		return sqrt(pow(x, 2) + pow(y, 2));
	}
private:
	int x;
	int y;
};
	
}