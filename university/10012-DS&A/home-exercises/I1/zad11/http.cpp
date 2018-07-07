#include "http.h"
#include <ctime>
using namespace std;

http::http(string url)
{
    this->url = url;
    port = 80; //def u zadatku
}

http::http(string url, int port)
{
    this->url = url;
     this->port = port;
}

string http::randstr(int size)
{
    srand(time(0));
    string temp;
    static const char alphanum[] =
        "0123456789"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < size; ++i) {
        temp.push_back(alphanum[rand() % (sizeof(alphanum) - 1)]);
    }

    return temp;
}

string http::get()
{
    return randstr(10);
}

string http::post()
{
    return randstr(10);
}