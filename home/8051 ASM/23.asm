;Sve parne brojeve s memorijskih lokacija od 30h do 3Fh zapišite na uzastopne memorijske
;lokacije počevši od 40h. Koristite petlju! (Ako na lokacijama od 30h do 3Fh nisu upisane nikakve
;vrijednosti, prvo pokrenite zadatak 21.)
MOV R0, #30h
MOV R1, #40h
MOV R2, #16

petlja:
	MOV A, @R0
	MOV B, #2
	DIV AB	
	MOV A, B
	JZ paran

	neparan: 
		INC R0
		DJNZ R2, petlja
		JMP kraj
	
	paran:
		MOV A, @R0
		MOV @R1, A
		INC R0
		INC R1
		DJNZ R2, petlja

kraj:

END

