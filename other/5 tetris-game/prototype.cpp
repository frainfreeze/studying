#include <string>
#include <vector>
#include <cstdlib>
#include <iostream>
#include <windows.h>
using namespace std;

struct Elements{
    string name;
    int posX;
    int posY;
};

vector <Elements> shapes;

int shapePosX;
int shapePosY;
int score;
bool game_over;

inline void clearScreen() {system("cls");} //inline for small performance boost

void init_game(){
    game_over = false;
    score = 0;
}

void screen(){
    string line(25,220);
    cout << "       T E T R I S\n";
    cout << line << endl;
    for(int i = 0; i<20; i++){
        for(int j = 0; j<25; j++){
            if(j==0 || j == 25-1 || i == 20-1){
                cout << char(219);
            } else {
                cout << " ";
            }
        }
        cout << endl;
    }
    Sleep(60); // smanjuje flicker, valjda jer pogodi screen refresh rate?
}

int main() {
    init_game();

    while(!game_over){
        clearScreen();
        screen();
    }

    return 0;
}
