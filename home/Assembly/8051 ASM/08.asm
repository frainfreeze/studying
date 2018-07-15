;zad 8, kvadriranje, zbrajanje i pohranja
MOV 31h, #14h  ;stavi podatak 14h na mem lok 31h 
MOV 32h, #2Eh  ;stavi podatak 2Eh na mem lok 32h
MOV a, 31h     ;stavi sadrzaj sa mem 31 u acc
MOV b, a       ;kopiraj acc u b
MUL ab         ;kvadriranje
MOV R0, a      ;spremi manje znacajne znamenke u r0
MOV R1, b      ;spremi vise znacajne znamenke u r1
MOV a, 32h     ;isto i za podatak 2eh
MOV b, a            
MUL ab         ;kvadriranje
ADD a, R0      ;zbrajanje nizih znamenaka
MOV 34h, a     ;spremanje nizih na mem lok 34h
MOV a, b       ;premjesti vise znamenke u a
ADD a, R1      ;zbroji sa visim znamenkama proslog broja
MOV 33h, a     ;premjesti vise znamenke u 33h
END