#include "http.h"
#include <iostream>
using namespace std;

int main()
{
    // Iskoristite tip podataka za dohvat podataka POST-om 
    http primjer("https://www.bla.com", 443);
    cout << primjer.post() <<endl;
    
    return 0;
}