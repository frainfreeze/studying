## Programming -- Principles and Practice Using C++


- [x] Chapter 0 - Notes to the Reader 1
- [x] Chapter 1 Computers, People, and Programming 17 (reread)

### [Part I The Basics](part1) 41
- [x] Chapter 2 - Hello, World! 43
- [x] Chapter 3 - Objects, Types, and Values 59
- [x] Chapter 4 - Computation 89
- [ ] Chapter 5 - Errors 133
- [ ] Chapter 6 - Writing a Program 173
- [ ] Chapter 7 - Completing a Program 221
- [ ] Chapter 8 - Technicalities: Functions, etc. 255
- [ ] Chapter 9 - Technicalities: Classes, etc. 303

### [Part II Input and Output](part2) 343
- [ ] Chapter 10 - Input and Output Streams 345
- [ ] Chapter 11 - Customizing Input and Output 379
- [ ] Chapter 12 - A Display Model 411
- [ ] Chapter 13 Graphics Classes 441
- [ ] Chapter 14 - Graphics Class Design 487
- [ ] Chapter 15 - Graphing Functions and Data 519
- [ ] Chapter 16 - Graphical User Interfaces 551

### [Part III Data and Algorithms](part3) 581
- [ ] Chapter 17 - Vector and Free Store 583
- [ ] Chapter 18 - Vectors and Arrays 627
- [ ] Chapter 19 - Vector, Templates, and Exceptions 667
- [ ] Chapter 20 - Containers and Iterators 711
- [ ] Chapter 21 - Algorithms and Maps 757

### [Part IV Broadening the View](part4)
- [ ] Chapter 22 Ideals and History 805
- [ ] Chapter 23 Text Manipulation 849
- [ ] Chapter 24 Numerics 889
- [ ] Chapter 25 Embedded Systems Programming 925
- [ ] Chapter 26 Testing 989
- [ ] Chapter 27 The C Programming Language 1021

### Part V Appendices 1071


### Notes
TODO: 
- copy and answer "review questions"
- pull out terms

#### Practical debug advice
Comment your code well. That doesn’t simply mean “Add a lot of com-
ments.” You don’t say in English what is better said in code. Rather, you
say in the comments — as clearly and briefl y as you can — what can’t be
said clearly in code:
- The name of the program
- The purpose of the program
- Who wrote this code and when
- Version numbers
- What complicated code fragments are supposed to do
- What the general design ideas are
- How the source code is organized
- What assumptions are made about inputs
- What parts of the code are still missing and what cases are still not handled
- Use meaningful names - That doesn’t simply mean “Use long names.”
- Use a consistent layout of code.
- Break code into small functions, each expressing a logical action.
	- Try to avoid functions longer than a page or two; most functions will be much shorter.
- Avoid complicated code sequences.
	- Try to avoid nested loops, nested if -statements, complicated condi-
	  tions, etc. Unfortunately, you sometimes need those, but remember
	  that complicated code is where bugs can most easily hide.
- Use library facilities rather than your own code when you can.
	- A library is likely to be better thought out and better tested than
	  what you could produce as an alternative while busily solving your
	  main problem.
