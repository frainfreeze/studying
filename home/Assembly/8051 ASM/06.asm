;zad 6, definiranje varijable znak i dodjeljivanje vrijednosti
;operacija ili nad akumulatorom i varijablom znak
ZNAK EQU 5Eh   ;definiranje var i dodjeljivanje vrijednosti
MOV a, #1Fh    ;upisivanje vrijednosti u akumulator
ORL a, #ZNAK   ;operacija ili iznad akumulatora i varijable
MOV 2Ch, a     ;pohrana rezultata na mem aresu 2Ch
END