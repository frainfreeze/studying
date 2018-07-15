;U akumulator pohranite vrijednost 65h, a u memorijsku lokaciju 29h vrijednost 68h.
;Umanjujte vrijednost na lokaciji 29h za 1 sve dok vrijednost na toj lokaciji ne bude 
;jednaka vrijednosti u akumulatoru.
MOV A, #65h
MOV 29h, #68h

petlja:
	DEC 29h
CJNE A, 29h, petlja

END