;zad 9, djeljenje
MOV a, #20h  ;stavi vrijednost 20h u acc
MOV 50h, #2  ;a na mem lok 50h vrijednost 2
MOV b, 50h   ;stavi vrijednost sa mem 50h u b
DIV ab       ;podjeli
MOV R3, a    ;spremi rez u registar r3
END