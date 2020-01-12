;U memorijske lokacije od 10h do 1Fh upišite brojeve od 44 do 29. Koristite petlju!
MOV A, #44
MOV R0, #10h
MOV R1, #16

petlja:
	MOV @R0, A
	INC R0
	DEC A
DJNZ R1, petlja

END
