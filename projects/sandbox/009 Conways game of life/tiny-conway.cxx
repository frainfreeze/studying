//frainfreeze, 2k18
//simple Conways game of life in c++
#include <iostream>
#include <bitset>
#include <ctime>

const int fieldSize = 800; //40x20
std::bitset<fieldSize> field;

void calculate() {
	std::bitset<fieldSize> nxtField;
	for (unsigned int i = 0; i < field.size(); ++i) {
		int neighbours = 0;
		neighbours += (i > 40  && field[i - 41]);
		neighbours += (i > 39  && field[i - 40]);
		neighbours += (i > 38  && field[i - 39]);
		neighbours += (i > 0   && field[i - 1]);
		neighbours += (i < 799 && field[i + 1]);
		neighbours += (i < 761 && field[i + 39]);
		neighbours += (i < 760 && field[i + 40]);
		neighbours += (i < 759 && field[i + 41]);

		if (neighbours < 2 || neighbours > 3) nxtField[i] = false;
		if ((neighbours == 3) || (field[i] == 1 && neighbours == 2)) nxtField[i] = true;
	}
	field = nxtField;
}

void draw(){
	system("cls");
	for (unsigned int i = 0; i < field.size(); ++i) {
		if (i % 40 == 0) std::cout << "\n";
        else field[i] ? std::cout << "#" : std::cout << " ";
	}
}

int main() {
	srand(static_cast<unsigned int>(time(nullptr)));

	for (unsigned int i = 0; i < field.size(); ++i) {
		if (!(rand() % 4)) field[i] = true;
	}

	int nxt;
	do {
		draw();
		calculate();
		std::cout << "\n\tQuit/Next (0/1): ";		
		std::cin >> nxt;
	} while (nxt);

	return 0;
}