#include <iostream>
#include "Tocka.cpp"

using namespace std;

void print(Tocka t) 
{
	cout << "t(" << t.x << ", " << t.y << ")" << endl;
}

int main() 
{
	Tocka t;
	t.x = 1;
	t.y = 2;

	print(t);

	t.x = -1;
	t.y = 2;

	print(t);

	return 0;
}