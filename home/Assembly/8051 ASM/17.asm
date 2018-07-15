;Koristeći akumulator, lokacije 63h i 64h zbrojite brojeve od 5 do 15. U svakom koraku
;petlje trenutni zbroj prenesite u stog, a nakon petlje prenesite zadnji rezultat iz stoga na lokaciju 6Ah.
;Prema potrebi koristite i druge memorijske lokacije. U Excelu kreirajte tablicu u koju ćete zapisati stanje
;svih memorijskih lokacija (uključujući i stack pointer!) u svakom prolasku kroz petlju.
MOV A, #5
MOV 63h, #6
MOV 64h, #10

LOOP:
	ADD A, 63h
	INC 63h
	MOV 65h, A
	PUSH 65h
DJNZ 64h, LOOP

POP 6Ah
END