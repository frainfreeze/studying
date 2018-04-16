;zad 3, oduzimanje, komplementiranje, inkrementiranje
;postavljene su zastavice CY (carry) i AC (auxiliary)
;cy je carry sa 7bita, bita najvece vaznosti,
;ac je carry sa 3 na 4 bit
MOV a, #12h   ;stavi vrijednsot u A registar
MOV b, #2Ah   ;stavi vrijednsot u B registar
SUBB a, b     ;oduzimanje. rez se pohranjuje u a
CPL a         ;komplementira registar a
INC a         ;inkrementira reg a
MOV R0, a     ;prenosenje rezultata u reg R0
END