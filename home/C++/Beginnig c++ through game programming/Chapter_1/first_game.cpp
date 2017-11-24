#include <iostream>
#include <ctime>

#define GUI_line "*******************************************\n"

using namespace std;

// My first C++ game.

enum difficulty { novice, intermediate, hardcore };
difficulty currentDifficulty;

int difficutlyChoosing() {

	difficulty currentDifficulty;
	char userDifficulty;
	cout << "Plase choose game difficulty level: \n";
	cout << "1. novice\n2. intermediate\n3. hardcore\n";

	cin >> userDifficulty;

	switch (userDifficulty)
	{
	case '1':
		currentDifficulty = novice;
		break;
	case '2':
		currentDifficulty = intermediate;
		break;
	case '3':
		currentDifficulty = hardcore;
		break;

	default:
		cout << "Error while setting difficutly.\n";
		currentDifficulty = novice;
		break;
	}
	return currentDifficulty;
}

int main() {

	cout << GUI_line << "Welcome to the most not amazing game ever. \nOur goal today is to learn how to use \ndifferent c++ types in game dev.\n" <<	GUI_line << endl;

	//lets call our difficulty choosing menu and print result
	cout << "difficulty set on: " << difficutlyChoosing()+1 << endl << GUI_line;

	char decision;
	cout << "A wild zombie apears on your right! \nFight (f) or run (r)?: ";
	cin >> decision;
	
	srand(time(NULL)); //Randomize seed initialization
	int randNum = rand() % 2; // Generate a random number between 0 and 1

	switch (decision)
	{
	case 'f':
		if (randNum) {
			cout << "\nYou survived!\n" << GUI_line;
		}
		else
		{
			cout << "\nYou died.\n" << GUI_line;
		}
		break;

	case 'r':
		if (randNum) {
			cout << "\nYou managed to run away...\n" << GUI_line;
		}
		else
		{
			cout << "\nZombie got you. You died.\n" << GUI_line;
		}
		break;

	default:
		cout << "\nBad input.\n" << GUI_line;
		break;
	}
	return 0;
}
