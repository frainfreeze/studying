#include "../std_lib_facilities.h"
/*
Write  a  program  to  test  an  integer  value  to  determine  if  it  is  odd  or
even. As always, make sure your output is clear and complete. In other
words,  don’t  just  output  yes  or  no.  Your  output  should  stand  alone,
like The value 4 is an even number. Hint: See the remainder (modulo) operator in §3.4.
*/
int main()
{
    cout << "enter an integer to test if it is odd or even: ";
    int valueToTest;
    cin >> valueToTest;

    if (valueToTest % 2 == 1){
        cout << valueToTest << " is an odd number\n";
    }else{
        cout << valueToTest << " is an even number\n";
    }

    return 0;
}