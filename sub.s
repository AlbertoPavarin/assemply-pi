.text @marca l'inizio del segmento di codice

.global main @definisce il punto d'inizio main come global
main:	mov r3, #16 @carica il primo operando
	mov r4, #3 @carica il secondo operando
	sub r1 , r3, r4 @ esegue la sottrazione
	mov pc, lr @ritorna il controllo al sistema operativo