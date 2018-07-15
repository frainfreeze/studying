;zad 1, zbrajanje brojeva 32h i 11h pomocu reg a i b
;i spremanje rez na memorijsku lokaciju 10h
MOV a, #32h  ;stavi 32h u reg A
MOV b, #11h  ;stavi 11h u reg B
ADD a,b      ;zbroji a i b i spremi rez u a
MOV 10h, a   ;premjesti rez na mem lokaciju 10h
END          ;kraj programa
