#include <string>
#include <vector>
#include <cstdlib>
#include <iostream>
#include <conio.h>
#include <windows.h>
using namespace std;

struct Elements{
    string name;
    int posX;
    int posY;
};

vector <Elements> shapes;
int ticker = 0;
int shapePosX = 10;
int shapePosY = 0;
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
            } else if(j == shapePosX && i==shapePosY){
                cout << char(219);
            } else cout << " ";
        }
        cout << endl;
    }
    if(shapePosY!=18 && (ticker%5==0)) shapePosY++;
    ticker++;
    Sleep(60); // smanjuje flicker, valjda jer pogodi screen refresh rate?
}

int main() {
    init_game();

    while(!game_over){
        clearScreen();
        screen();

        if (GetAsyncKeyState (VK_LEFT) && shapePosX>1 && shapePosX <=23) {
            shapePosX--;
        }
        if (GetAsyncKeyState (VK_RIGHT) && (shapePosX>=1 && shapePosX <23)) {
            shapePosX++;
        }
        if (GetAsyncKeyState (VK_DOWN) && (shapePosY!=18)) {
            shapePosY++;
        }
    }

    return 0;
}
