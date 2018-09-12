#include <iostream>
#include <conio.h>  
#include <stdio.h>  
#include <string>
#include <fstream>
#include <windows.h>

using namespace std;
// fraifnreeze 2017
// Google chrome's t-rex game in c++, console
// ──────────────────────────────────────────────────────────────────────────────
//                                                                  HI 1000 25
//
//
//
//
//
//
//  ╠                         ╗
// ╚╣╠          ▓            ╗╠╝
// ──────────────────────────────────────────────────────────────────────────────

int bazaIO(int score, int foo = 0);
void game_over_Screen();

void clearScreen() {system("cls");}

int score;
int scoreHigh = 1000; // = bazaIO(score);
bool game_over = false;

string line(78, 196);

char cacti1up[] = { ' ', 204, ' '};
char cacti1down[] = { 200,185,204 };

char cacti2up[] = { ' ', 187 };
char cacti2down[] = { 187,204,188 };

void screen(bool is_up) {
	clearScreen();
	
	char character = char(178);
	
	cout << line << endl;
	cout << "\t\t\t\t\t\t\t\t HI " << scoreHigh << " " << score << endl << endl  << endl << endl << endl;
	
	cout << "             ";
	if (is_up) cout << character << "            " << endl; else cout << "             " << endl;
	 cout << "             " << endl;

	for (int i = 0; i < sizeof(cacti1up) / sizeof(char); i++){cout << cacti1up[i];}
	
	cout << "                       ";

	for (int i = 0; i < sizeof(cacti2up) / sizeof(char); i++){cout << cacti2up[i];}

	cout << endl;

	for (int i = 0; i < sizeof(cacti1down) / sizeof(char); i++){cout << cacti1down[i];}
	cout << "          ";
	if (!is_up) cout << character << "            "; else cout << "             ";
	for (int i = 0; i < sizeof(cacti2down) / sizeof(char); i++){cout << cacti2down[i];}
	cout << endl << line;
	Sleep(50);

}

int main(void)
{
	system("color f0"); // invert console color
	int counter = 0;
	bool is_up = false;

	while(!game_over) {
		screen(is_up);
		if (_getch() == '\r') is_up = true;
		screen(is_up);
		is_up = false;
		score+=25;
		if(score==400) system("color 0f");
		else if (score == 800) system("color f0");
		else if (score == 1200) system("color 0f");
		if (score == 500) game_over_Screen();
	}


	if (score > scoreHigh) {
		bazaIO(score, 1);
	}
}


int bazaIO(int score, int foo) {
	int temp = 0;
	if (foo == 0) {
		ifstream myfile("score.txt");
		if (myfile.is_open()) {
			cin >> temp;
		}
		else cout << "nemogu otvoriti bazu.\n";
		return temp;
	}
	else {
		ofstream myfile("score.txt");
		if (myfile.is_open()) {
			myfile << score;
		}
		else cout << "nemogu otvoriti bazu.\n";
	}
}

void game_over_Screen() {
	clearScreen();
	cout << line << endl << "\t\t\t\t\t\t\t\t HI " << scoreHigh << " " << score;
	cout << "\n\n\n\n \t\t\t G A M E   O V E R \n\n\n\n\n";
	cout << line << endl;
	game_over = true;
}
