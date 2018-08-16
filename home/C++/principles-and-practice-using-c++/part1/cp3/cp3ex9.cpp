#include "../std_lib_facilities.h"
/*
Write  a  program  that  converts  spelled-out  numbers  such  as  “zero”  and
“two” into digits, such as 0 and 2. When the user inputs a number, the
program should print out the corresponding digit. Do it for the values 0,
1, 2, 3, and 4 and write out not a number I know if the user enters some-
thing that doesn’t correspond, such as stupid computer!.
*/
int main()
{
    cout << "enter a spelled out integer: ";
    int toBeSpelled = -1;
    string inputNumber;

    while (cin >> inputNumber)
    {
        if (inputNumber == "zero") toBeSpelled = 0;
        else if (inputNumber == "one") toBeSpelled = 1;
        else if (inputNumber == "two") toBeSpelled = 2;
        else if (inputNumber == "three") toBeSpelled = 3;
        else if (inputNumber == "four") toBeSpelled = 4;
        else if (inputNumber == "Quit" || inputNumber == "quit") return 0;
        if (toBeSpelled != -1)
            cout << "you entered number " << toBeSpelled << '\n';
        else
            cout << "I dont know that number\n";
        cout << "Please enter another number or \"Quit\"\n";
        toBeSpelled = -1;
    }
    return 0;
}