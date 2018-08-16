#include <iostream>
#include <string>
#include <vector>
using namespace std;
int main()

{
    vector<string> s_digits = {"zero","one","two","three","four","five","six","seven","eight","nine"};
    vector<string> i_digits = {"0","1","2","3","4","5","6","7","8","9"};


    string inp = "";
    while (cin>>inp) {
        bool was_found = false;
        for (int i = 0; i<s_digits.size(); ++i) {
            if (s_digits[i]==inp) {
                cout << i << endl;
                was_found = true;
            }
            if (i_digits[i]==inp) {
                cout << s_digits[i] << endl;
                was_found = true;
            }
        }
        if (!was_found)
            cout << "Input must be zero, one, ..., nine or 0-9\n";
    }
}
