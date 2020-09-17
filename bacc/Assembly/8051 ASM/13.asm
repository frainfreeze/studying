;Koristeći akumulator, lokaciju 2Fh i lokaciju 30h, pomnožite sve brojeve od 1 do 6.
MOV A, #1
MOV 2Fh, #2
MOV 30h, #5
petlja:
	MOV B, 2Fh
	MUL AB
	INC 2Fh
DJNZ 30h, petlja

; Rezultat pohranite na lokacijama 51h i 52h.
MOV 51h, B
MOV 52h, A
END