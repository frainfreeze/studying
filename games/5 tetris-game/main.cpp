#include <string>
#include <vector>
#include <cstdlib>
#include <iostream>
#include <conio.h>
#include <windows.h>
#include <algorithm>
using namespace std;

struct onscreen{
    int x;
    int y;
};

vector<onscreen> elements;

vector<int> used {18};

int ticker = 0; // for shape falling speed
int shapePosX = 10;
int shapePosY = 0;

bool can_fit;
bool game_over;

inline void clearScreen() {system("cls");}

void init_game(){
    game_over = false;
    can_fit = true;
}

bool isUsed(int posY){
    for(int i = 0; i<used.size(); i++){
        if(posY == used[i]){
            return true;
        } else {
            return false;
        }
    }
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
    if(isUsed(shapePosY)){
        can_fit = false;   
        used.push_back(shapePosY+1);
        onscreen temp;
        temp.x = shapePosX;
        temp.y = shapePosY;
        elements.push_back(temp);
    }
    
    ticker++;
    Sleep(60);
}

int main() {
    init_game();
    cin.get();
    while(!game_over){
        clearScreen();
        screen();

        if (GetAsyncKeyState (VK_LEFT) && shapePosX>1 && shapePosX <=23 && (can_fit) ) {
            shapePosX--;
        }
        if (GetAsyncKeyState (VK_RIGHT) && (shapePosX>=1 && shapePosX <23) && (can_fit) ) {
            shapePosX++;
        }
        if (GetAsyncKeyState (VK_DOWN) && (can_fit)) {
            shapePosY++;
        }
    }

    return 0;
}
