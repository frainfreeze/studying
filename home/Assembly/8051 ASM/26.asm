;Počevši od memorijske lokacije 10h, pronađite prvih 8 lokacija koje su prazne (u kojima
;piše broj 0). Adrese pronađenih lokacija zapišite u stog. Zatim te adrese vratite na memorijske lokacije
;od 70h do 77h, ali tako da je najmanja adresa zapisana u 70h, a najveća u 77h. Na kraju, u svaku od tih
;praznih lokacija upišite njezinu vlastitu adresu.
MOV R0, #10h
MOV R1, #70h
MOV R2, #8h

cc:
	MOV A, @R0
	JZ jenula
	INC R0
	JMP cc

jenula:
	MOV A, R0
	MOV @R1, A
	INC R1
	INC R0
	DJNZ R2, cc
	
END