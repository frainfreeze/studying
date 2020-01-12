#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <algorithm> // for random_shuffle()
using namespace std;
/*
frainfreeze dec 2017.

# Word Jumble
Word Jumble is a puzzle game in which the computer creates a version of a
word where the letters are in random order. The player has to guess the word to
win the game. If the player is stuck, he or she can ask for a hint

Bonus: add scoring system. Make the point value for a word based on its length.
Deduct points if the player asks for a hint.
*/

int main()
{
    srand(static_cast<unsigned int>(time(0))); //seed the generator
    enum fields {WORD, HINT, NUM_FIELDS}; // using last enum value for array size
    const int NUM_WORDS = 5;

    const string WORDS[NUM_WORDS][NUM_FIELDS] =
    {
     {"wall","You can hang pictures on it."},
     {"glass","You can pour water in it to drink from it."},
     {"bottle","...of good wine."},
     {"big","opposite of small"},
     {"creative","artistic, has interesting ideas"},
    }; //2 dimensional array[y][x]

    // let s pick a word for the player
    int choice = (rand()%NUM_WORDS); // lets pick random word
    string theWord = WORDS[choice][WORD]; // utilizing power of enums, WORD is always 0
    string theHint = WORDS[choice][HINT];

    // now we have to jumble it
    /*string jumble = theWord;
    for(int i = 0; i < theWord.length(); i++){
        int index1 = (rand()%theWord.length());
        int index2 = (rand()%theWord.length());
        char temp = jumble[index1];
        jumble[index1] = jumble[index2];
        jumble[index2] = temp;
    }*/

    string jumble = theWord;
    random_shuffle(jumble.begin(), jumble.end());


    cout << "\t\t\tWelcome to Word Jumble!\n\n";
    cout << "Unscramble the letters to make a word.\n";
    cout << "Enter 'hint' for a hint.\n";
    cout << "Enter 'quit' to quit the game.\n\n";
    cout << "The jumble is: " << jumble;

    int score = 0;

    string guess;
    cout << "\n\nYour guess: ";
    cin >> guess;

    while ((guess != theWord) && (guess!= "quit")){
        if(guess == "hint"){
            cout << theHint << endl;
            score - 10;
        } else{
            cout << "Sorry, that's not it." << endl;
        }

        cout << "Your guess: ";
        cin >> guess;
    }

    if (guess == theWord){
        cout << "That's it! You guessed it!" << endl;
        for(int i = 0; i<theWord.length(); i++){
            score+3;
        }
    }

    cout << "Your score is: " << score << ". Thanks for playing." << endl;
    return 0;
}