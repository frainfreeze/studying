#include <iostream>
#include <string>
#include <cstdlib> // for random numbers
#include <time.h>
using namespace std;

/*
# Guess My Number
The computer chooses a random number between 1 and 100, and
the player tries to guess the number in as few attempts as possible.
Each time the player enters a guess, the computer tells him whether the guess is too high,
too low, or right on the money. Once the player guesses the number, the game is
over and number of attempts is displayed.

Bonus: make computer guess number player picked!
Bonus2: highscores
 */

const string line(30, '-'); // line = 30 times '-'

// function prototypes
void challengePC(string nickname);
void playAgainstPC(string nickname);

int main()
{
    srand(static_cast<unsigned int>(time(0))); // seeding rand generator, we need unsigned int

    cout << "Guess My Number game" << endl;
    cout << line << endl;

    string nickname;
    int choice;

    cout << "Enter your nickname: ";
    getline(cin, nickname);

    cout << "Hi " << nickname << ", do you want to challenge PC or play against it?" << endl;

    do{

    cout << "\nenter 1 to challenge PC, 2 to play against it, 3 to quit: ";
    cin >> choice;

    switch (choice){
    case 1:
        challengePC(nickname);
        break;
    case 2:
        playAgainstPC(nickname);
        break;
    case 3:
        cout << "Bye!" << endl;
        break;
    default:
        cout << "Please enter numbers 1-3!" << endl;
    }
    } while (choice!=3); // loops until player enters 3, alt; for(;;) if break

    return 0;
}


//function definitions
void challengePC(string nickname){
    //finish me!
    cout << "Hi " << nickname << ". I'll try to guess your number." << endl;
    cout << "If I guessed correctly enter 0, if I said number too low enter 1, if I said number too high enter 2!" << endl;

    int temp;
    int counter = 0;
    int middle = 50;
    int tooLow;
    int tooHigh;

     do{
        cout << "Is your number " << middle << "?" << endl;;
        cout << "->";
        cin >> temp;

       counter++;
    } while(temp); // while not 0

    cout << "Whew! It took me " << counter-1 << " attempts to guess your number. Good game!" << endl;
}

void playAgainstPC(string nickname){
    cout << "Hi " << nickname << ". I guessed number between 1 and 100." << endl;
    cout << "Enter a number and I ll tell you whether its too high or too low!" << endl;

    int randNum = (rand()%100) + 1; // random number between 1 and 100
    int temp;
    int counter = 0;

    do{
        cout << "->";
        cin >> temp;
        if(temp>randNum){
            cout << "Too high!" << endl;
            counter++;
        } else if(temp<randNum){
            cout << "Too low!" << endl;
            counter++;
        } else if(temp==randNum){
            cout << "Correct!" << endl;
        }
    } while(temp != randNum);

    cout << "Congrats, you guessed the number in just " << counter << " attempts." << endl;
}