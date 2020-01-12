#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

string not_string(string a) {
    if (a.length()>=3 && !a.substr(0,3).find("not"))
        return a;
    else;
        return "not " + a;
}

int main() {
    cout << not_string("candy") << endl;
    cout << not_string("x") << endl;
    cout << not_string("not bad") << endl;
	return 0;
}
