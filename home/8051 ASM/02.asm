;zad 2, monozenje brojeva 12h i 0Fh pomocu A i B te
;oduzimanje 02h
MOV a, #12h   ;stavi vrijednsot u A registar
MOV b, #0Fh   ;stavi vrijednsot u B registar
MUL ab        ;mnozenje, nizi bitovi idu u a visi u b
SUBB a, #02h  ;osuzimanje. rez se pohranjuje u a
END           ;kraj programa
;zastavica preliva ce se postaviti u 1 a visak u reg b
