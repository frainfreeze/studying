;U registar R6 upišite podatak 75h. 
MOV R6, #75h

;Na najjednostavniji način umanjite taj podatak za 1 pa
DEC R6

;rezultat prenesite na lokaciju 29h. 
MOV 29h, R6

;Podatak s lokacije 29h zatim uvećajte za 1 (ponovo, nanajjednostavniji način!) 
INC 29h

;pa rezultat prenesite u stog.
PUSH 29h
END