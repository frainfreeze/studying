#ifndef HTTP_H_
#define HTTP_H_
#include <string>
using namespace std;

class http{
private:
    string url;
    int port;
    string randstr(int size);

public:
    // Želite korisnicima omogućiti da pri izradi objekta mogu zadati 
    //samo  URL  (pa  se  podrazumijeva  port  80)  ili  i  URL i port.
    http(string url);
    http(string url, int port);
    
    // Pružite korisnicima metode get i post bez parametara 
    // koje vraćaju neki slučajni string od 10 znakova
    string get();
    string post();
};
#endif //HTTP_H_