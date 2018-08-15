#include <iostream>
#include <cstring>
using namespace std;

/* This example creates and initializes two strings, fragment1 and 
fragment2. fragment3 is declared but not initialized. finalString 
is partially initialized (with just the null character). fragment1 
is copied into fragment3 using strcpy, in effect initializing fragment3 
to I'm a s. strcat is then used to concatenate fragment3 onto finalString
(the function overwrites the existing null character), thereby giving 
finalString the same contents as fragment3. Then strcat is used again 
to concatenate fragment2 onto finalString. finalString is displayed, 
giving I'm a string!.  */

int main() 
{
    char fragment1[] = "I'm a s";
    char fragment2[] = "tring!";
    char fragment3[20];
    char finalString[20] = "";
    strcpy(fragment3, fragment1);
    strcat(finalString, fragment3);
    strcat(finalString, fragment2);
    cout << finalString;
return 0;}