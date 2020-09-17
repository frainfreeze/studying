;Upišite na memorijsku lokaciju 25h proizvoljan broj, a memorijske lokacije 26h i 27h ispraznite. 
;Provjerite je li broj na lokaciji 25h paran. Ako jest, upišite broj 1 na lokaciju 26h; u suprotnom
;upišite broj 1 na lokaciju 27h.
MOV 25h, #52
MOV 26h, #0
MOV 27h, #0
MOV B, #2

MOV A, 25h
DIV AB
MOV A, B
JZ paran

neparan:
	MOV 27h, #1
	JMP kraj

paran:
	MOV 26h, #1

kraj:
END 