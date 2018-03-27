A priori analiza
- Vrijeme izvršavanja (engl. running time) je vrijeme potrebno da izvođenje algoritma dođe do kraja
- Izražavat ćemo ga u broju operacija, a ne sekundi
- T(1000) = 2981 znači da trajanje algoritma na 1000 ulaznih podataka iznosi 2981 operaciju
- Da bismo mogli prebrojati operacije, moramo odlučiti koji tip analize želimo raditi:
    - best case scenario
    - worst case scenario
    - average case scenario

A posteori analiza
- predstavlja analizu izvođenja programa na nekom stvarnom računalu
- umjesto logičkih operacija mjerimo duljinu izvođenja programa
- Što je kraće vrijeme izvođenja, program smatramo boljim

Mjerenje brzine koda
```cpp
// Stoperica.h
#pragma once
#include <chrono>
class Stoperica {
    private:
    std::chrono::time_point<std::chrono::high_resolution_clock> t1;
    std::chrono::time_point<std::chrono::high_resolution_clock> t2;
public:
    void start();
    void stop();
    long long get_elapsed_milliseconds();
};
```
```cpp
// Stoperica.cpp
#include "Stoperica.h"
void Stoperica::start() {
    t1 = std::chrono::high_resolution_clock::now();
}
void Stoperica::stop() {
    t2 = std::chrono::high_resolution_clock::now();
}
long long Stoperica::get_elapsed_milliseconds() {
    return std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count();
}
```

```cpp
// Source.cpp
#include <iostream>
#include "Stoperica.h"
using namespace std;
int main() {
    Stoperica sw;
    sw.start();
    long long s = 0;
    for (int i = 0; i < 2100000000; i++) {
        s += i;
    }
    sw.stop();
    long long trajanje = sw.get_elapsed_milliseconds();
    cout << "Trajanje " << trajanje << " ms" << endl;
    return 0;
}