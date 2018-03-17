#include <iostream>
#include <fstream>

#include <SFML/Graphics.hpp>

#include "VertParse.h"

using namespace std;
/*

*/
void generate_sample_model(const std::string& filename) {
    std::ofstream outFile;
    outFile.open(filename);
    if (outFile) {
        outFile << "# Test VERT File\n# Summary\nquadNum      =      1\n# quad             \nquad.a.x     =      0\nquad.a.y \
                     =      0\nquad.b.x     =      0\nquad.b.y     =      0\nquad.c.x     =      0                  \n \
                    quad.c.y     =      0\nquad.d.x     =      0\nquad.d.y     =      0";
    }
}

int main(){
    // generate test file
    //generate_sample_model("test1.vert");

    // create QuadContainer to test parser
    QuadContainer bar;

    // make VerParser instance and load model
    VertParser spaz;
    spaz.loadVert("test1.vert");

    // test the parser
    bar = spaz.get_container();

    cout << endl << "Number of quads: " << bar.numQuads << "\nVector size: " << bar.quads.size() << endl;
    cout << "foo.a.x = " << bar.quads[0].a.x << endl;
    cout << "foo.a.y = " << bar.quads[0].a.y << endl;
    cout << "foo.b.x = " << bar.quads[0].b.x << endl;
    cout << "foo.b.y = " << bar.quads[0].b.y << endl;
    cout << "foo.c.x = " << bar.quads[0].c.x << endl;
    cout << "foo.c.y = " << bar.quads[0].c.y << endl;
    cout << "foo.d.x = " << bar.quads[0].d.x << endl;
    cout << "foo.d.y = " << bar.quads[0].d.y << endl;
    cout << endl;
    cout << "foo.a.x = " << bar.quads[1].a.x << endl;
    cout << "foo.a.y = " << bar.quads[1].a.y << endl;
    cout << "foo.b.x = " << bar.quads[1].b.x << endl;
    cout << "foo.b.y = " << bar.quads[1].b.y << endl;
    cout << "foo.c.x = " << bar.quads[1].c.x << endl;
    cout << "foo.c.y = " << bar.quads[1].c.y << endl;
    cout << "foo.d.x = " << bar.quads[1].d.x << endl;
    cout << "foo.d.y = " << bar.quads[1].d.y << endl;


    return 0;
}
