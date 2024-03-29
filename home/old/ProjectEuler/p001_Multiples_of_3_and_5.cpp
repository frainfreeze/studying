#include <iostream>
using namespace std;

/*
if we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000. (result: 233168)
*/

double MAX_MULTI = 1000;
int result = 0;

void findMultiples(int c = 0){
    if(c==1000){
        cout << result;
        return;
    } else {
        if(c%3==0||c%5==0){
            result = result + c;
        }
    }
    c++;
    findMultiples(c);
}

int main(){
    findMultiples();
    return 0;
}