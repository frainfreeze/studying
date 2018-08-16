#include <vector>
#include <iostream>
#include <stdexcept>
using namespace std;

void foo()
{
    vector<int> v;                     // a vector  ints
    int i;
    while (cin>>i) v.push_back(i);     // get values
    for (int i = 0; i<=v.size(); ++i)  // print values
        cout << "v[" << i <<"] == " << v[i] << endl;
}


void bar()
{
    vector<int> v(5);
    int x = v[5];
}


int main(){
    try {
        vector<int> v;                     // a vector  ints
        int x;
        while (cin>>x) v.push_back(x);     // set values, ctrl-d to jump out
        for (int i = 0; i<=v.size(); ++i)  // print values
            cout << "v[" << i <<"] == " << v[i] << endl;
    } catch (out_of_range) {
        cerr << "Oops! Range error\n";
        return 1;
    } catch (...) {                        // catch all other exceptions
        cerr << "Exception: something went wrong\n";
        return 2;
    }
}