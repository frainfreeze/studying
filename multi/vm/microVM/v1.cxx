/* 
 *  ### Register based Virtual Machine ###
 *  Simple architecture consisted of:
 *  1. Registers (4 of them) that will serve as 
 *     a group of read/write memory cells
 *  2. A program that is read-only sequence of VM 
 *     instructions
 *  3. Execution unit that reads each instruction
 *     in order and executes it
 *  
 *  Addressing modes
 *  - Register numbers begin with the letter r, eg. r2.
 *  - Immediate (scalar) values begin with the hash mark #, eg. #100
 *  - Memory addresses begin with the at sign @, eg. @1004.
 * 
 *  Instruction set
 *  We want to make VM able to:
 *  - load a constant into a register 
 *  - perform sum on two registers
 *  - halt the machine
 * 
 *  Short program using that instruction set:
 *  1| loadi r0 #100
 *  2| loadi r1 #200
 *  3| add r2 r0 r1 
 *  4| halt
 * 
 *  1. Load the immediate value 100 into the register r0. 
 *    (load operation is placing a value into a register)
 *  2. Load the immediate value 200 into register r1.
 *  3. Add the contents of registers r0 and r1 and place the sum into register r2.
 *  4. End the program and halt the VM.
 */
