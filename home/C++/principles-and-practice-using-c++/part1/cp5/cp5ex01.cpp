#include "../../std_lib_facilities.h"

// calculate are of a rectangle;
// pre-conditions: length and width are positive
// post-condition: returns a positive value that is the area
int area(int length, int width)
{
    if (length<=0 || width<=0) error("area() pre-condition");
    int a = length*width;
    cout << a << endl;
    if (a<=0) error("area() post-condition");
    return a;
}

int main()
try
{
    int test = area(1000000,1000000);
    return 0;
}
catch (exception& e) {
    cerr << "error: " << e.what() << endl;
    return 1;
}
catch (...) {
    cerr << "Oops: unknown exception!\n";
    return 2;
}