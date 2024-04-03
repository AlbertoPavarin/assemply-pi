.text @marca l'inizio del segmento di codice

.global main @definisce il punto d'inizio main come global
main:	mov r1, #16 @carica il primo operando
	mov r2, #3 @carica il secondo operando
	subs r0, r1, r2
	bmi inv
	bpl end
inv:	rsb r0, r0, #0
end:	mov pc, lr @ritorna il controllo al sistema operativo