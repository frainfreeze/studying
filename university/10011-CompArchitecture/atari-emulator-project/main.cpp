
#include<SFML/Graphics.hpp>
#include<SFML/Audio.hpp>
#include<SFML/Window.hpp>
#include<iostream>
#include<functional>        //for std::bind
#include<math.h>        //Astar libraries
#include<float.h>
#include<vector>
#include<set>
#include<string.h>
#include<string>
#include<sstream>
using namespace std;
using namespace sf;
#define num 60      //number of cells in a row


vector<pair<int,int>> pathD;        //Shortest pathD
bool sptSet[num][num];      //explored cells
void findmin(float dist[num][num],int& min_x,int& min_y){
    float mini=FLT_MAX;
    for(int i=0;i<num;i++)
        for(int j=0;j<num;j++)
            if(!sptSet[i][j] && dist[i][j] < mini){
                mini=dist[i][j];
                min_x=i;
                min_y=j;
            }
}
void findpath(pair<int,int> previous[num][num],float dist[num][num],int dest_x,int dest_y,int source_x,int source_y){
    cout<<"\nLength of Dijkstra path is: "<<dist[dest_x][dest_y]<<endl;
    while(previous[dest_x][dest_y].first!=source_x || previous[dest_x][dest_y].second!=source_y){        // both simultaneously equal to source coordinates
        sf::sleep(milliseconds(10));        //delay shortest pathD
        cout<<"go to ->\n("<<previous[dest_x][dest_y].first<<","<<previous[dest_x][dest_y].second<<") ";
        pathD.emplace_back(previous[dest_x][dest_y].first,previous[dest_x][dest_y].second);
        int save_x=dest_x,save_y=dest_y;
        dest_x=previous[save_x][save_y].first;
        dest_y=previous[save_x][save_y].second;
    }
}

typedef pair<int,int> previous[num][num];

void dijkstra(int source_x, int source_y, int dest_x, int dest_y, int grid[num][num]){
    previous previous;
    float dist[num][num];
    for (auto &i : dist)
        for (float &j : i)
            j =FLT_MAX;
    dist[source_x][source_y]=0.0;
    int found=0;
    for(int i=0;i<num && found==0;i++)
        for(int j=0;j<num;j++){
            int min_x=0,min_y=0;
            findmin(dist,min_x,min_y);
            sptSet[min_x][min_y]=true;
            if(sptSet[dest_x][dest_y]){
                found=1;
                break;
            }
            sf::sleep(milliseconds(1));        //delay exploration
            //north
            if (dist[min_x - 1][min_y] > dist[min_x][min_y] + 1.0) {
                if (grid[min_x - 1][min_y] == 1 && !sptSet[min_x - 1][min_y]) {
                    dist[min_x - 1][min_y] = static_cast<float>(dist[min_x][min_y] + 1.0);
                    previous[min_x - 1][min_y] = make_pair(min_x, min_y);
                }
            }
            //south
            if (dist[min_x + 1][min_y] > dist[min_x][min_y] + 1.0) {
                if (grid[min_x + 1][min_y] == 1 && !sptSet[min_x + 1][min_y]) {
                    dist[min_x + 1][min_y] = static_cast<float>(dist[min_x][min_y] + 1.0);
                    previous[min_x + 1][min_y] = make_pair(min_x, min_y);
                }
            }
            //west
            if (dist[min_x][min_y - 1] > dist[min_x][min_y] + 1.0) {
                if (grid[min_x][min_y - 1] == 1 && !sptSet[min_x][min_y - 1]) {
                    dist[min_x][min_y - 1] = static_cast<float>(dist[min_x][min_y] + 1.0);
                    previous[min_x][min_y - 1] = make_pair(min_x, min_y);
                }
            }
            //east:i,j+1
            if (!sptSet[min_x][min_y + 1]) {
                if (grid[min_x][min_y + 1] == 1 && dist[min_x][min_y + 1] > dist[min_x][min_y] + 1.0) {
                    dist[min_x][min_y + 1] = static_cast<float>(dist[min_x][min_y] + 1.0);
                    previous[min_x][min_y + 1] = make_pair(min_x, min_y);
                }
            }
            //north-east:i-1,j+1
            if (dist[min_x - 1][min_y + 1] > dist[min_x][min_y] + sqrt(2)) {
                if (grid[min_x - 1][min_y + 1] == 1 && !sptSet[min_x - 1][min_y + 1] && !(grid[min_x - 1][min_y] == 0 && grid[min_x][min_y + 1] == 0)) {
                    dist[min_x - 1][min_y + 1] = static_cast<float>(dist[min_x][min_y] + sqrt(2));
                    previous[min_x - 1][min_y + 1] = make_pair(min_x, min_y);
                }
            }
            //south-east:i+1,j+1
            if (dist[min_x + 1][min_y + 1] > dist[min_x][min_y] + sqrt(2)) {
                if (grid[min_x + 1][min_y + 1] == 1 && !sptSet[min_x + 1][min_y + 1] && !(grid[min_x + 1][min_y] == 0 && grid[min_x][min_y + 1] == 0)) {
                    dist[min_x + 1][min_y + 1] = static_cast<float>(dist[min_x][min_y] + sqrt(2));
                    previous[min_x + 1][min_y + 1] = make_pair(min_x, min_y);
                }
            }
            //south-west:i+1,j-1
            if (dist[min_x + 1][min_y - 1] > dist[min_x][min_y] + sqrt(2)) {
                if (grid[min_x + 1][min_y - 1] == 1 && !sptSet[min_x + 1][min_y - 1] && !(grid[min_x + 1][min_y] == 0 && grid[min_x][min_y - 1] == 0)) {
                    dist[min_x + 1][min_y - 1] = static_cast<float>(dist[min_x][min_y] + sqrt(2));
                    previous[min_x + 1][min_y - 1] = make_pair(min_x, min_y);
                }
            }
            //north-west:i-1,j-1
            if (dist[min_x - 1][min_y - 1] > dist[min_x][min_y] + sqrt(2)) {
                if (grid[min_x - 1][min_y - 1] == 1 && !sptSet[min_x - 1][min_y - 1] && !(grid[min_x - 1][min_y] == 0 && grid[min_x][min_y - 1] == 0)) {
                    dist[min_x - 1][min_y - 1] = static_cast<float>(dist[min_x][min_y] + sqrt(2));
                    previous[min_x - 1][min_y - 1] = make_pair(min_x, min_y);
                }
            }
        }
    findpath(previous,dist,dest_x,dest_y,source_x,source_y);
}

//--------main()--------
int main(){
    int filled[num][num];       //whether cell is colored
    int grid[60][60];           //map with obstacle
    for(int i=0;i<60;i++)
        for(int j=0;j<60;j++){
            if(i==0||i==59||j==0||j==59)        //walls
                grid[i][j]=0;
            else
                grid[i][j]=1;
        }
     for(int i=0;i<num;i++)
        for(int j=0;j<num;j++){
            sptSet[i][j]=false;     //dijkstra all unexplored
            filled[i][j]=0;     //all uncolored
        }

    int source_x=2,source_y=2,dest_x=50,dest_y=56;      //Origin(2,3)->Goal(50,56)
    Thread threadD(std::bind(&dijkstra,source_x,source_y,dest_x,dest_y,grid));
    RenderWindow window(VideoMode(800,600),"Grid");

    // Text
    sf::Font font;
    font.loadFromFile("arial.ttf");
    sf::Text text1("DIJKSTRA",font,15);
    sf::Text lengthD(" ",font,24);
    sf::Text lengthA(" ",font,24);
    text1.setFillColor(Color::Black);
    lengthD.setFillColor(Color::Black);
    lengthA.setFillColor(Color::Black);
    // Shapes
    RectangleShape buttonStartD(Vector2f(75,25));       //button dijkstra
    buttonStartD.setFillColor(Color::Green);

    RectangleShape displayD(Vector2f(75,25));       //Dijkstra display
    displayD.setFillColor(Color::White);

    RectangleShape rectangle(Vector2f(10,10));      //default box :White
    rectangle.setFillColor(Color::White);
    RectangleShape brectangle(Vector2f(10,10));     //Black box
    brectangle.setFillColor(Color::Black);
    RectangleShape grectangle(Vector2f(10,10));     //Green
    grectangle.setFillColor(Color::Green);
    grectangle.setOutlineThickness(2);
    grectangle.setOutlineColor(Color::Red);
    RectangleShape mrectangle(Vector2f(10,10));     //Magenta
    mrectangle.setFillColor(Color::Magenta);
    mrectangle.setOutlineThickness(2);
    mrectangle.setOutlineColor(Color::Red);
    RectangleShape blueRectangle(Vector2f(10,10));
    blueRectangle.setFillColor(Color::Blue);
    blueRectangle.setOutlineThickness(2);
    blueRectangle.setOutlineColor(Color::Red);
    RectangleShape rrectangle(Vector2f(10,10));
    rrectangle.setFillColor(Color::Red);
    rrectangle.setOutlineThickness(2);
    rrectangle.setOutlineColor(Color::Red);
    RectangleShape yrectangle(Vector2f(10,10));
    yrectangle.setFillColor(Color::Yellow);
    // Display
    while(window.isOpen()){
        Event event;
        while(window.pollEvent(event)){
            if(event.type==Event::Closed)
                window.close();
            if(event.type==Event::KeyPressed&& event.key.code==Keyboard::Space)
                window.close();
            if(event.type==Event::MouseButtonPressed&&event.mouseButton.button==Mouse::Left){
                int X=event.mouseButton.x;
                int Y=event.mouseButton.y;
                int row=Y/10;       //Reversed notion of row & column
                int col=X/10;
                if(grid[row][col]==0&&row<60&&col<60)
                    grid[row][col]=1;
                else if(row<60&&col<60)
                    grid[row][col]=0;
                cout<<"Cell "<<row<<" , "<<col<<" state is: "<<grid[row][col]<<endl;
                if(X>600&&X<675&&Y>0&&Y<25){
                    threadD.launch();

                }
            }
        }
        window.clear();
        buttonStartD.setPosition(600,0);
        window.draw(buttonStartD);      //Dijkstra launch
        displayD.setPosition(725,0);        //Dijkstra length Background
        window.draw(displayD);

        text1.setPosition(600,0);       //Dijkstra text

        lengthD.setPosition(725,0);     //Display Dijkstra length
        lengthA.setPosition(725,75);
        window.draw(text1);

        stringstream ss1,ss2;
        ss1<<pathD.size();       //int2string
        lengthD.setString(ss1.str());

        lengthA.setString(ss2.str());
        window.draw(lengthD);
        window.draw(lengthA);

        if(!pathD.empty()){
            for (auto &i : pathD) {
                grectangle.setPosition(i.second*10, i.first*10);     //Reversed notion of row & column
                window.draw(grectangle);        //final pathD
                filled[i.first][i.second]=1;
            }
        }
        blueRectangle.setPosition(source_y*10,source_x*10);
        window.draw(blueRectangle);     //source
        filled[source_x][source_y]=1;
        rrectangle.setPosition(dest_y*10,dest_x*10);
        window.draw(rrectangle);        //destination
        filled[dest_x][dest_y]=1;
        for(int i=0;i<=590 ;i+=10)
            for(int j=0;j<=590;j+=10){
                if(grid[i/10][j/10]==0){
                    brectangle.setOutlineThickness(2);
                    brectangle.setOutlineColor(Color::Red);
                    brectangle.setPosition(j,i);
                    window.draw(brectangle);        //User's obstacle
                }
                if(sptSet[i / 10][j / 10] && filled[i / 10][j / 10] == 0){
                    yrectangle.setOutlineThickness(2);
                    yrectangle.setOutlineColor(Color::Red);
                    yrectangle.setPosition(j,i);
                    window.draw(yrectangle);        // Explored Cells by dijkstra
                }

                if(grid[i/10][j/10]==1 && !sptSet[i / 10][j / 10] && filled[i / 10][j / 10] == 0){     //not in dijkstra
                    rectangle.setOutlineThickness(2);
                    rectangle.setOutlineColor(Color::Red);
                    rectangle.setPosition(j,i);
                    window.draw(rectangle);     //default white cells
                }
            }
        window.display();
    }
    return 0;
}

