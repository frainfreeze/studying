;zad 10, zbroj brojeva 1 do 15 pomocu acc i 2 mem lok
MOV 1Fh, #15        ;stavi 15 na mem lok 1Fh
Hmhm:               ;label
	ADD a, 1Fh      ;zbroji acc i vrijednost na 1Fh
	DJNZ 1Fh, Hmhm  ;umanji vrijednost na lok 1Fh i skoci
MOV 21h, a          ;spremi rezultat na mem lok 21h
END