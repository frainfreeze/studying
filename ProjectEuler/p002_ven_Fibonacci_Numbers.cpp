#include <iostream>
using namespace std;

/*
Each new term in the Fibonacci sequence is generated by adding the previous two terms.
By starting with 1 and 2, the first 10 terms will be: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, f
ind the sum of the even-valued terms.
Result : 4613732
*/

double MAX_FIBO = 4000000;
int result = 0;

void fibo(int a, int b){
    int temp;
    if(a<MAX_FIBO){;
        temp = b;
        b = a + b;
        a = temp;

        if(a%2==0){
            result=result+a;
        }

    } else {
        cout << result;
        return 0;
    }
    fibo(a,b);
}

int main(){
    fibo(1,2);
    return 0;
}