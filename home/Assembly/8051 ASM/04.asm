;4 zad, prenos podatka u indirektno adresiranu mem lokaciju,
;zatim u akumulator oa inkrementacija i prenos na lok 2Bh
MOV R0, #2Ah   ;adresiraj 2Ah s reg r0
MOV @R0, #51h  ;mov 51h u 2Ah preko r0 (indirektno adresiranje)
MOV a, @R0     ;prenos podatka u akumulator
INC a          ;inkrementiranje
MOV 2Bh, a     ;pohrana rezultata na 2Bh
END
