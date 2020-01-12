;U akumulator upišite vrijednost F1h,
MOV A, #0F1h

; a na lokaciju 42h vrijednost 42h. 
MOV 42h, #42h

; Izvršite operaciju XOR nad upisana dva podatka
XRL A, 42h

;dobiveni rezultat pohranite na adresu 43h koristeći indirektno adresiranje preko registra R1.
MOV R1, #43h
MOV @R1, A
END