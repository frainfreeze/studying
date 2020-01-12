;Koristeći indirektno adresiranje preko registra R0, na adresu 20h upišite vrijednost 1Eh.
;Uvećajte podatak u registru R0 za 1. Koristeći indirektno adresiranje, na lokaciju čija je adresa upisana
;u R0 upišite vrijednost 1Fh.
MOV R0, #20h
MOV @R0, #1Eh
INC R0
MOV @R0, #1Fh
END
