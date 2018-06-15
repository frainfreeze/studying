#include <iostream>
#include <chrono>
#include <thread>

bool end = false;
int steps = 0;
char field[20][40];
struct point { int x = 0, y = 0; } start, dest, current, goal;

int main() { //sramim se.
	int q, e, r, t;
	std::cout << "Unesite a.x, a.y, b.x, b.y s razmacima izmedu brojeva (a 0-19, b 0-39): ";
	std::cin >> q >> e >> r >> t; //sanatize input??
	start = { q,e };
	dest = { r,t };
	current = start;
	field[5][1] = '*'; field[5][2] = '*'; field[5][3] = '*'; field[5][4] = '*';

	while (!end) {
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
		system("CLS");
		if (current.x == goal.x && current.y == goal.y) end = true;
		else { // path finding
			if (current.x != goal.x && field[current.x + 1][current.y] != '*')  current.x++;
			else if (current.y != goal.y && field[current.x][current.y + 1] != '*') current.y++;
			steps++;
		}

		for (int i = 0; i < 20; ++i) {//fill array
			for (int j = 0; j < 40; ++j) {
				if (field[i][j] == 'B') goal = { i,j };
				if (i == start.x && j == start.y)                 field[i][j] = 'A';
				else if (i == dest.x  && j == dest.y)             field[i][j] = 'B';
				else if (i == 0 || j == 0 || i == 19 || j == 39) field[i][j] = '*';
				else {
					if (field[i][j] != 'x' && field[i][j] != '*') field[i][j] = '-';
					field[current.x][current.y] = 'x';
				}
			}
		}

		for (int i = 0; i < 20; ++i) {
			for (int j = 0; j < 40; ++j) 
				std::cout << field[i][j];
			std::cout << "\n";
		}
	}
	std::cout << "done in: " << steps << " steps." << "\n";
	return 0;
}
