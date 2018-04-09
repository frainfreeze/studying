//lvalue is short for "left hand side value" (of and assignment)
int var;
// 3+3 would be non lvalue expression

// rvalue is short for "right hand side value" because
// values appear on the right side of an assigment
// for eg (x+5) in
var = (x+5);


int x = (int)5.0; // float should be explicitly "cast" to int
short s = 3;
float y = s+3.4; //compiler convers implicitly to float for addition

//operator precedence http://imgur.com/B8Pc74Vl.png

// ternary operator ?:
if(a>b)
    result = x;
else
    result = y;

result = a > b ? x : y;

// loops
for(; --n>0 ;)
