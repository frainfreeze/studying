;Na memorijske lokacije 2Ah i 2Bh upišite dva proizvoljna broja. Usporedite ih pa na
;memorijsku lokaciju 2Ch upišite FFh ako su brojevi jednaki, Ah ako je veći broj na lokaciji 2Ah, odnosno
;Bh ako je veći broj na lokaciji 2Bh.
MOV 2Ah, #10h
MOV 2Bh, #20h

MOV A, 2Ah
MOV B, 2Bh
CJNE A, B, drukciji

isti:
	MOV 2Ch, #0FFh
	JMP kraj

drukciji:
	SUBB A, B
	JC BGRT
	MOV 2Ch, #2Ah
	JMP kraj

BGRT:
	MOV 2Ch, #2Bh

kraj:

END
