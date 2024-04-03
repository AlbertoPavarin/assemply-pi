.text @marca l'inizio del segmento di codice

.global main @definisce il punto d'inizio main come global
main:	mov r1, #10
loop:	subs r1, r1, #1
	bne loop
	mov r0, #10