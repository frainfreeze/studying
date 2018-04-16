;zad 7, operacija I, pohranjivanje rezultata pomocu
;indirektnog adresiranja
MOV a, #0E3h   ;stavi E3h u acc
MOV 40h, #92h  ;stavi vrijednost 92h na mem lok 40h
ANL a, 40h     ;operacija I nad podatcima
MOV R0, #41h   ;adresiraj mem lok 41h na reg r0
MOV @R0, a     ;premjesti sadrzaj acc na 41h ind. add.
END