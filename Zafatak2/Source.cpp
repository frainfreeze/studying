#include <iostream>
#include <chrono>
#include <thread>

char field[20][40];
int q, e, r, t, steps;
struct point { int x = 0, y = 0; } start, dest, last, atm, goal;

int main() { //sramim se.
    std::cout << "Unesite a.x, a.y, b.x, b.y s razmacima izmedu brojeva (a 0-19, b 0-39): ";
    std::cin >> q >> e >> r >> t; //sanitize input??
    start = { q,e }, dest = { r,t }, atm = start;
    field[5][1] = '*'; field[5][2] = '*'; field[5][3] = '*'; field[5][4] = '*';
    field[16][33] = '*'; field[17][31] = '*'; field[18][30] = '*'; 

    while (!(atm.x == goal.x && atm.y == goal.y)) {
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
if((atm.x != goal.x && field[atm.x + 1][atm.y] != '*') && (atm.x+1 != last.x))  {
            last.x = atm.x;
            atm.x++;
        } else if ((atm.y != goal.y && field[atm.x][atm.y + 1] != '*') && (atm.y+1 != last.y )){
            last.y = atm.y; last.x = atm.x;
            atm.y++;
        } else if ((field[atm.x - 1][atm.y] != '*') && (atm.x-1 != last.x))  {// ne radi ako se doda atm goal??? ((atm.x != goal.x && field[atm.x - 1][atm.y] != '*') && (atm.x-1 != last.x))  {
            last.x = atm.x;
            atm.x--;
        } else if ((atm.y != goal.y && field[atm.x][atm.y - 1] != '*') && (atm.y-1 != last.y )){
            last.y = atm.y;
            atm.y--;
        } 
        system("CLS");
        steps++;

        for (int i = 0; i < 20; ++i) {//fill array
            for (int j = 0; j < 40; ++j) {
                if (field[i][j] == 'B') goal = { i,j };
                if (i == start.x && j == start.y)                 field[i][j] = 'A';
                else if (i == dest.x  && j == dest.y)             field[i][j] = 'B';
                else if (i == 0 || j == 0 || i == 19 || j == 39)  field[i][j] = '*';
                else {
                    if (field[i][j] != 'x' && field[i][j] != '*') field[i][j] = '-';
                    field[atm.x][atm.y] = 'x';
                } std::cout << field[i][j];
            } std::cout << "\n";
        }
    }
    std::cout << "done in: " << steps << " steps." << "\n";
    return 0;
}
