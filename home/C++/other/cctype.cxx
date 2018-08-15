#include <iostream>
#include <cctype>
using namespace std;

/* This example uses the isalpha, isupper, ispunct, and 
tolower functions from the cctype library. The is- functions
check whether a given character is an alphabetic character, an 
uppercase letter, or a punctuation character, respectively. 
These functions return a Boolean value of either true or false. 
The tolower function converts a given character to lowercase. 
The for loop beginning at line 9 takes each successive character from 
messyString until it reaches the null character. On each iteration, 
if the current character is alphabetic and uppercase, it is converted 
to lowercase and then displayed. If it is already lowercase it is 
simply displayed. If the character is a punctuation mark, a space is 
displayed. All other characters are ignored. */

int main() {
    char messyString[] = "t6H0I9s6.iS.999a9.STRING";
    char current = messyString[0];
    for(int i = 0; current != '\0'; current = messyString[++i]) {
        if(isalpha(current))
            cout << (char)(isupper(current) ? tolower(current) : current);
        else if(ispunct(current))
            cout << ' ';
    }
    cout << endl;
return 0;
}
