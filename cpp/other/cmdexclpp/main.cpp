// biggest todo: stop crossing 80 cols!
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <algorithm>
#include <chrono>
#include <iostream>
using namespace std;

// globals
string line_underscore (76,'_'); string line_score (76,'-');
string line_thin(76,196); string line_double_thin(76,205);
string line_bold_up(76,223); string line_bold_down(76,220); string line_bold_fat(76,219);
string line_fat_dots(76,177);

string getFileContents(ifstream& File);

auto start_time = chrono::high_resolution_clock::now();

struct Cell { //17x8=133
    int cell_pos;
    string data; // actuall data
    string cell; // to be displayed, 8 chars
};

void clearScreen() {
	#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
		system("clear");
	#endif

	#if defined(_WIN32) || defined(_WIN64)
		system("cls");
	#endif
}

void pauseX() {
	#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
        cout << "Implement me!\endl";
	#endif

	#if defined(_WIN32) || defined(_WIN64)
		system("PAUSE");
	#endif
}

void setConsoleColor(int consoleColorSheme = 0, bool interactive_mode = false) {
    if(interactive_mode==true){
        clearScreen();
        cout << line_fat_dots << endl;
        cout << "Available color schemes: \n";
        cout << "\t\t0 - default\n\t\t1 - inverted\n\t\t2 - blue-white\n\t\t3 - white-purple\n\t\t4 - black-red\n\t\t5 - purple-white\n\t\t6 - black-yellow\n\t\t7 - light aqua-black\n\t\t8 - black-light aqua\n\t\t9 - black-green\n";
        cout << line_fat_dots << endl;
        cout << "Enter color scheme number: ";
        cin >> consoleColorSheme;
        cin.ignore();
    }
	#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
		cout << "Implement me!\endl";
	#endif

	#if defined(_WIN32) || defined(_WIN64)
        if(consoleColorSheme==0) system("color 0f"); // default
        if(consoleColorSheme==1) system("color f0"); // inverted
        if(consoleColorSheme==2) system("color 97"); // blue-white
        if(consoleColorSheme==3) system("color f5"); // white-purple
        if(consoleColorSheme==4) system("color 0c"); // black-red
        if(consoleColorSheme==5) system("color 5f"); // purple-white
        if(consoleColorSheme==6) system("color 0e"); // black-yellow
        if(consoleColorSheme==7) system("color 30"); // light aqua-black
        if(consoleColorSheme==8) system("color 03"); // black-light aqua
        if(consoleColorSheme==9) system("color 0a"); // black-green
	#endif
}


// function prototypes
int clockx();
void splash();
int dbIO(vector<Cell>& sheet, int option);
void calc(vector<Cell>& sheet);
void clean(vector<Cell>& sheet);
int screen(vector<Cell>& sheet, int status=0, bool changes = true);

void insertx(vector<Cell>& sheet);
void clearx(vector<Cell>& sheet);
void help();
void test(vector<Cell>& sheet);

int menu(vector<Cell>& sheet){
    screen(sheet,1,0);

    string temp;
    getline(cin,temp);
    if(temp == ":i" || temp == ":insert") insertx(sheet);
    else if(temp == ":t" || temp == ":test") test(sheet);
    else if(temp == ":r" || temp == ":recalculate"){ calc(sheet); clean(sheet); screen(sheet);}
    else if(temp == ":c" || temp == ":clear"){ clearx(sheet); screen(sheet);}

    else if(temp == ":sc" || temp == ":setcolor") setConsoleColor(0,1);
    else if(temp == ":h" || temp == ":help") help();
    else if(temp == ":s" || temp == ":splash") splash();
    else if(temp == ":q" || temp== ":quit") return -1;
    else help(); // i find this prettier than switch cases, gotta check performance comparison later tho
    return 0;
}

int main() {
    vector<Cell> sheet;
    // fill sheet with nothing
    for(int i = 0;i<134;i++){
        Cell temp;
        temp.cell_pos = i;
        temp.data = "0";
        temp.cell = "        ";
        sheet.push_back(temp);
    }

    splash(); // write splash screen

    // program
    dbIO(sheet,1); // read file into vector

    while(menu(sheet)!=-1); // enter menu

	return 0;
}

int clockx(){
    return chrono::duration_cast<chrono::seconds>(chrono::high_resolution_clock::now() - start_time).count();
}

void splash(){
    clearScreen();
    ifstream Reader("splash.txt");
    string Art = getFileContents(Reader);
    cout << Art << endl;
    Reader.close ();
    pauseX();
}

int dbIO(vector<Cell>& sheet,int option){
    return 0;
}


void calc(vector<Cell>& sheet){
} // probably future bootleneck

void clean(vector<Cell>& sheet){
} // probably future bootleneck

int screen(vector<Cell>& sheet, int status, bool changes){
    // calculate everything, prepare(clean) data, clear screen, set stuff on screen
    calc(sheet);
    clean(sheet);
    clearScreen();

    string statusTxt, changesTxt;
    if(status==0) statusTxt = "editing"; else statusTxt = "viewing";
    if(changes==true) changesTxt="Unsaved changes"; else changesTxt = "Everything saved";

    cout << line_thin << endl;
    cout << "Status: " << statusTxt << " | Current editing time: " << clockx() << " seconds | " << changesTxt << endl;
    cout << line_double_thin << endl;
    cout << "   " << "|" << "   a    " << "|" << "   b    " << "|" << "   c    " << "|" << "   d    " << "|" << "   e    " << "|" << "   f    " << "|" << "    g   " << "|" << "    h   " << "|"<<'\n';
    cout << "---+--------+--------+--------+--------+--------+--------+--------+--------+\n";
    cout << "1  " << "|" << sheet[0].cell << "|" << sheet[1].cell << "|" << sheet[2].cell << "|" << sheet[3].cell << "|" << sheet[4].cell << "|" << sheet[5].cell << "|" << sheet[6].cell << "|" << sheet[7].cell << "|" <<'\n';
    cout << "2  " << "|" << sheet[8].cell << "|" << sheet[9].cell << "|" << sheet[10].cell << "|" << sheet[11].cell << "|" << sheet[12].cell << "|" << sheet[13].cell << "|" << sheet[14].cell << "|" << sheet[15].cell << "|" <<'\n';
    cout << "3  " << "|" << sheet[16].cell << "|" << sheet[17].cell << "|" << sheet[18].cell << "|" << sheet[19].cell << "|" << sheet[20].cell << "|" << sheet[21].cell << "|" << sheet[22].cell << "|" << sheet[23].cell << "|" <<'\n';
    cout << "4  " << "|" << sheet[24].cell << "|" << sheet[25].cell << "|" << sheet[26].cell << "|" << sheet[27].cell << "|" << sheet[28].cell << "|" << sheet[29].cell << "|" << sheet[30].cell << "|" << sheet[31].cell << "|" <<'\n';
    cout << "5  " << "|" << sheet[32].cell << "|" << sheet[33].cell << "|" << sheet[34].cell << "|" << sheet[35].cell << "|" << sheet[36].cell << "|" << sheet[37].cell << "|" << sheet[38].cell << "|" << sheet[39].cell << "|" <<'\n';
    cout << "6  " << "|" << sheet[40].cell << "|" << sheet[41].cell << "|" << sheet[42].cell << "|" << sheet[43].cell << "|" << sheet[44].cell << "|" << sheet[45].cell << "|" << sheet[46].cell << "|" << sheet[47].cell << "|" <<'\n';
    cout << "7  " << "|" << sheet[48].cell << "|" << sheet[49].cell << "|" << sheet[50].cell << "|" << sheet[51].cell << "|" << sheet[52].cell << "|" << sheet[53].cell << "|" << sheet[54].cell << "|" << sheet[55].cell << "|" <<'\n';
    cout << "8  " << "|" << sheet[56].cell << "|" << sheet[57].cell << "|" << sheet[58].cell << "|" << sheet[59].cell << "|" << sheet[60].cell << "|" << sheet[61].cell << "|" << sheet[62].cell << "|" << sheet[63].cell << "|" <<'\n';
    cout << "9  " << "|" << sheet[64].cell << "|" << sheet[65].cell << "|" << sheet[66].cell << "|" << sheet[67].cell << "|" << sheet[68].cell << "|" << sheet[69].cell << "|" << sheet[70].cell << "|" << sheet[71].cell << "|" <<'\n';
    cout << "10 " << "|" << sheet[70].cell << "|" << sheet[71].cell << "|" << sheet[72].cell << "|" << sheet[73].cell << "|" << sheet[74].cell << "|" << sheet[75].cell << "|" << sheet[76].cell << "|" << sheet[77].cell << "|" <<'\n';
    cout << "11 " << "|" << sheet[78].cell << "|" << sheet[79].cell << "|" << sheet[80].cell << "|" << sheet[81].cell << "|" << sheet[82].cell << "|" << sheet[83].cell << "|" << sheet[84].cell << "|" << sheet[85].cell << "|" <<'\n';
    cout << "12 " << "|" << sheet[86].cell << "|" << sheet[87].cell << "|" << sheet[88].cell << "|" << sheet[89].cell << "|" << sheet[90].cell << "|" << sheet[01].cell << "|" << sheet[92].cell << "|" << sheet[93].cell << "|" <<'\n';
    cout << "13 " << "|" << sheet[94].cell << "|" << sheet[95].cell << "|" << sheet[96].cell << "|" << sheet[97].cell << "|" << sheet[98].cell << "|" << sheet[99].cell << "|" << sheet[100].cell << "|" << sheet[101].cell << "|" <<'\n';
    cout << "14 " << "|" << sheet[102].cell << "|" << sheet[103].cell << "|" << sheet[104].cell << "|" << sheet[105].cell << "|" << sheet[106].cell << "|" << sheet[107].cell << "|" << sheet[108].cell << "|" << sheet[109].cell << "|" <<'\n';
    cout << "15 " << "|" << sheet[110].cell << "|" << sheet[111].cell << "|" << sheet[112].cell << "|" << sheet[113].cell << "|" << sheet[114].cell << "|" << sheet[115].cell << "|" << sheet[116].cell << "|" << sheet[117].cell << "|" <<'\n';
    cout << "16 " << "|" << sheet[118].cell << "|" << sheet[119].cell << "|" << sheet[120].cell << "|" << sheet[121].cell << "|" << sheet[122].cell << "|" << sheet[123].cell << "|" << sheet[124].cell << "|" << sheet[125].cell << "|" <<'\n';
    cout << "17 " << "|" << sheet[126].cell << "|" << sheet[127].cell << "|" << sheet[128].cell << "|" << sheet[129].cell << "|" << sheet[130].cell << "|" << sheet[131].cell << "|" << sheet[132].cell << "|" << sheet[133].cell << "|" <<'\n';
    cout << line_bold_up << endl;
    cout << "Enter command:" << endl;
    return 0;
}

void insertx(vector<Cell>& sheet){
}

void clearx(vector<Cell>& sheet){
    clearScreen();
    string temp;
    cout << "\n\n\n\n\n\n\n\n\n\t\t\t!!! WARNING !!!!\n\tAre you absolutely sure you want to empty whole sheet?\n\tType 'yes' to proceed, anything else to cancel: ";
    getline(cin,temp);
    if(temp=="yes"){
        for(int i = 0;i<134;i++){
            sheet[i].cell_pos = i;
            sheet[i].data = "0";
            sheet[i].cell = "        ";
        }
    }
}

void help(){
    clearScreen();
    cout << "\n\n\n\t\tHelp:\n";
    cout << "\t\t - :i, :insert -> insert mode, [row][column]-[data]\n";
    cout << "\t\t - :r, :recalculate -> recalculates sheet manually\n";
    cout << "\t\t - :c, :clear -> empties sheet\n";
    cout << '\n';
    cout << "\t\t - :sc, :setcolor -> console color scheme chooser screen\n";
    cout << "\t\t - :s, :splash -> display splash screen\n";
    cout << "\t\t - :h, :help -> displays this page\n";
    cout << "\t\t - :q, :quit -> exits program\n";
    cout << "\n\n\n";
    pauseX();
}

void test(vector<Cell>& sheet){
    for(int i = 0;i<134;i++){
        sheet[i].cell_pos = i;
        sheet[i].data = "0";
        sheet[i].cell = "  test  ";
    }
}

string getFileContents(ifstream& File){
    string Lines = "";
    if (File){
        while (File.good ()){
            string TempLine;
            getline (File , TempLine);
            TempLine += "\n";
            Lines += TempLine;
        }
        return Lines;
    }
    else { return "ERROR File does not exist."; }
}
