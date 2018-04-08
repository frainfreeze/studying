#include <iostream>
using namespace std;

// generic function
template <typename T>
T findSmaller(T input1, T input2)
{
    if(input1<input2)
        return input1;
    else
        return input2;
}

template <class myType>
myType findGreater (myType a, myType b) {
 return (a>b?a:b);
}

//tells the compiler that this is a function-template
template<class TYPE> 
// TYPE is template type parameter
void PrintTwice(TYPE data)
{
    cout<<"Twice: " << data * 2 << endl;
}

int main()
{
    int a = 54; 
    int b = 89;
    float f1 = 7.8;
    float f2 = 9.1;
    char c1 = 'f';
    char c2 = 'h';
    string s1 = "Hello";
    string s2 = "Bots are fun";
    
    cout << "\nIntegers compared: " << findSmaller(a,b);
    cout << "\nFloats compared: " << findSmaller(f1,f2);
    cout << "\nChars compared: " << findSmaller(c1,c2);
    cout << "\nStrings compared: " << findSmaller(s1,s2);   
    
    cout << "\n";
    PrintTwice(124);
    PrintTwice(3.25);
    
    cout << "\n";
    cout << findGreater(11.2,3.2);

    cout << "\n";
    return 0;
}