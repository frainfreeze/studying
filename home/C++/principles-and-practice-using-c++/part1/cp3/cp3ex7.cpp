#include "../std_lib_facilities.h"
/*
Do exercise 6, but with three string values. So, if the user enters the values
Steinbeck, Hemingway, Fitzgerald, the output should be Fitzgerald, Hemingway, Steinbeck.
*/
int main()
{
    string a, b, c;
    cout << "enter 3 words: ";
    cin >> a >> b >> c;

    // sorting by first letters
    while(!(a[0]<=b[0] && b[0]<=c[0])){
        if(a[0]>b[0]){
            string temp = a;
            a = b;
            b = temp;
        }

        if(b[0]>c[0]){
            string temp = b;
            b = c;
            c = temp;
        }
    }

    cout << a << ", " << b << ", " << c << endl;
    return 0;
}