;Počevši od lokacije 50h, u memoriju upišite prvih 13 članova Fibonaccijevog niza, tako da
;su članovi upisani u svaku drugu memorijsku lokaciju. Smatrajte da niz počinje članom 1. 
;Koristite petlju!
MOV R0, #0h
MOV R1, #50h
MOV R2, #13h
MOV B, #1h

FIB:
	MOV A, B
	MOV B, R0
	ADD A, B
	MOV @R1, A
	MOV R0, A
	INC R1
	INC R1
DJNZ R2, FIB

END
	