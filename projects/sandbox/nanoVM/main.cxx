#include <stdio.h>
#include <iostream>
#include <iomanip>

#define NUM_REGS 4

unsigned regs[NUM_REGS];

unsigned program[] = { 0x1064, 
                       0x11C8, 
                       0x2201, 
                       0x0000 };

//program counter
int pc = 0;

//the VM runs until this flag becomes 0
int running = 1;

//instruction fields
int instrNum = 0;
int reg1     = 0;
int reg2     = 0;
int reg3     = 0;
int imm      = 0;


int hex2dec(int x)
{
    int y;
    std::stringstream ss;
    ss << x;
    ss >> std::hex >> y;
    return y;
}

//fetch the next word from the program
int fetch()
{
    return program[pc++];
}

//decode a word
//( extracting individual bytes from a larger word )
// so/10493411
void decode( int instr )
{
    instrNum = (instr & 0xF000) >> 12; //mask followed by a shift
    reg1     = (instr & 0xF00 ) >>  8;
    reg2     = (instr & 0xF0  ) >>  4;
    reg3     = (instr & 0xF   );
    imm      = (instr & 0xFF  );
}

//evaluate the last decoded instruction
void eval()
{
    switch( instrNum ) {
    case 0: //halt
        std::cout << "halt\n";
        running = 0;
        break;
    
    case 1: //loadi
        printf( "loadi r%d #%d\n", reg1, imm );
        regs[reg1] = imm;
        break;

    case 2: //add
        printf( "add r%d r%d r%d\n", reg1, reg2, reg3 );
        regs[reg1] = regs[reg2] + regs[reg3];
        break;
    }
}

/* display all registers as 4-digit hexadecimal words */
void showRegs()
{
    std::cout << "regs = ";

    for(int i = 0; i < NUM_REGS; i++)
        printf( "%04X ", regs[i]);
  
  std::cout << "\n";
}

//fetch, then decode, then execute
void run()
{
    while(running) {
        showRegs();
        int instr = fetch();
        decode(instr);
        eval();
    }
    showRegs();
    std::cout << "100 + 200 = " << regs[2] << "\n";
}


int main()
{
    run();
    return 0;
}