;zad 5, pomocu registara a i b kvadrirajte broj 1Ch.
;vise znacajne znamenke rezultata pohranite u r1 a manje u r2
MOV a, #1Ch   ;stavi podatak u a
MOV b, a      ;kopiraj a u b
MUL ab        ;pomnozi a i b (kvadriranje)
MOV R1, b     ;vise znacajne znamenke u r1
MOV R2, a     ;manje znacajne u r2
END