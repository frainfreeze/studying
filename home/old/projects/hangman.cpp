#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <ctime>
#include <cctype> // has function to convert characters to uppercase

using namespace std;

/*
frainfreeze dec 2017.
# hangman
In the Hangman program, the computer picks a secret word and the player
tries to guess it one letter at a time.
The player is allowed eight incorrect guesses.
If he or she fails to guess the word in time,
the player is hanged and the game is over.
*/

int main()
{
    const int MAX_WRONG = 8; // max wrong guesses

    vector<string> words;
    words.push_back("TEST");
    words.push_back("HANGMAN");
    words.push_back("BAMBOOZLE");

    srand(static_cast<unsigned int>(time(0))); // seed the rnd generator
    random_shuffle(words.begin(), words.end()); // shuffle words vector elements

    const string theWord = words[0]; // lets pick the first word in vector
    string soFar(theWord.length(), '_'); // word placeholder based on its length

    int wrong = 0; // wrong guesses so far
    string usedLetters = ""; // letters used so far
    char letter;

    cout << "Welcome to hangman game. Good luck!\n\n";

    do {
        cout << "You have " << MAX_WRONG - wrong << " guesses left.\n";
        cout << "You have used following letters: " << usedLetters << endl;
        cout << "So far the word is: " << soFar << endl << endl;

        cout << "Enter your guess: ";
        cin >> letter;
        letter = toupper(letter); // make uppercase because words are too

        while (usedLetters.find(letter)!=string::npos){ // if letter in string
            cout << "\nYou already tried " << letter << endl;
            cout << "Enter your guess: ";
            cin >> letter;
            letter = toupper(letter);
        }

        usedLetters += letter;

        if(theWord.find(letter)!=string::npos){
            cout << "\nNice guess!\n";

            for(int i = 0; i < theWord.length();i++){
                if(theWord[i] == letter){
                    soFar[i] = letter;
                }
            }
        } else {
            cout << "\nSorry, the letter isn't int he word.\n";
            ++wrong;
        }

    } while(wrong < MAX_WRONG && soFar!= theWord);

    if (wrong < 8){
        cout << "Good game!\n";
    } else{
        cout << "Better luck next time.\n";
    }

    cout << "The word was " << theWord << endl;
    return 0;
}