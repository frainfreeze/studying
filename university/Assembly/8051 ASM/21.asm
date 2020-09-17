;U memorijske lokacije od 30h do 3Fh upišite sve brojeve djeljive s 3 počevši od 6 na više,
;tj. 6, 9, 12, 15... Koristite petlju!
MOV R0, #30h
MOV A, #6
MOV R1, #16

petlja:
	MOV @R0, A
	INC R0
	ADD A, #3
DJNZ R1, petlja

END