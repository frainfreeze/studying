;Na memorijske lokacije 31h i 32h pohranite brojeve 16h i 2Eh. 
MOV 31h, #16h
MOV 32h, #2Eh

;Kvadrirajte oba broja i zatim zbrojite dobivene kvadrate. 
MOV A, 31h
MOV B, A
MUL AB
MOV R1, B
MOV R0, A
MOV A, 32h
MOV B, A
MUL AB
ADD A, R0

;Više značajne znamenke rezultata pohranite na memorijsku lokaciju 33h, 
;a manje značajne na memorijsku lokaciju 34h. Osigurajte da se, 
;(samo!) u slučaju pojavljivanja prijenosa prilikom zbrajanja, 
;taj prijenos ne izgubi pri spremanju konačnih rezultata.
MOV 34h, A
MOV A, B
ADDC A, R1
MOV 33h, A
END