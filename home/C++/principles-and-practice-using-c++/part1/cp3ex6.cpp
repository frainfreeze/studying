#include "../std_lib_facilities.h"
/*
Write a program that prompts the user to enter three integer values, and 
then outputs the values in numerical sequence separated by commas. So, 
if the user enters the values 10 4 6, the output should be 4, 6, 10. If two 
values are the same, they should just be ordered together. So, the input 4 5 4
should give 4, 4, 5.
*/
int main()
{
    int a, b, c;
    cout << "enter 3 nums: ";
    cin >> a >> b >> c;

    while(!(a<=b && b<=c)){
        if(a>b){
            int temp = a;
            a = b;
            b = temp;
        }

        if(b>c){
            int temp = b;
            b = c;
            c = temp;
        }
    }

    cout << a << ", " << b << ", " << c << endl;
    return 0;
}