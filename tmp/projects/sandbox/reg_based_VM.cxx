/**
# Register based Virtual Machine
Simple architecture consisted of:
1. Registers (4 of them) that will serve as a group of read/write memory cells
2. A program that is read-only sequence of VM instructions
3. Execution unit that reads each instruction in order and executes it

## Addressing modes
- Register numbers begin with the letter r, eg. r2.
- Immediate (scalar) values begin with the hash mark #, eg. #100
- Memory addresses begin with the at sign @, eg. @1004.

## Instruction set
We want to make VM able to:
- load a constant into a register 
- perform sum on two registers
- halt the machine

Short program using that instruction set:
```asm
 1| loadi r0 #100
 2| loadi r1 #200
 3| add r2 r0 r1 
 4| halt
```

 1. Load the immediate value 100 into the register r0. 
   (load operation is placing a value into a register)
 2. Load the immediate value 200 into register r1.
 3. Add the contents of registers r0 and r1 and place the sum into register r2.
 4. End the program and halt the VM.

## Instruction codes
The first digit of a machine word is the instruction number. 
This gives our VM the potential for having up to 16 different instructions. 
The next three digits are used for the operands. These can be used as three 
1-digit operands, two operands of 1 and 2 digits, or a single 3-digit operand.

our current instruction encoding list:
```
0 = halt
1 = loadi
2 = add
```

There are three hexadecimal digits available for operands, so we will use the 
first of those three as the register number, and the second and third together 
as the immediate value. 

encoding it: 
```
bits 15-12 = 1
bits 11- 8 = register number
bits  7- 0 = immediate value
```

The register number for this instruction is 0, and the immediate value is 100, 
which in hexadecimal is 64 (6 x 16 + 4). Thus, the complete 16-bit hexadecimal 
instruction code for the first instruction is 1064.

Putting the instructions together, we get these 4 16-bit hexadecimal numbers as the complete program:

```
1064
11C8
2201
0000
```
*/

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