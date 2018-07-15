;Definirajte varijablu adresa i dodijelite joj vrijednost 13h.
adresa EQU 13h

;U akumulator upišite vrijednost 2Ch
MOV A, #2Ch

;a na lokaciju čija je adresa zapisana u varijabli adresa upišite vrijednost E4h.
MOV adresa, #0E4h

;Izvršite logičku operaciju ILI nad akumulatorom i varijablom adresa
ORL A, adresa

; a zatim rezultat pohranite na lokaciju 14h.
MOV 14h, A
END