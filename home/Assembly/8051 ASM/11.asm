;Podijelite brojeve 12h i 0Fh pomoću registara A i B. 
MOV A, #12h
MOV B, #0Fh
DIV AB

;Ostatku dodajte 2 i tako dobiveni rezultat pohranite u registar R7.
MOV A, B
ADD A, #2
MOV R7, A
END