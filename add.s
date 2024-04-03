.text @marca l'inizio del segmento di codice

.global main @definisce il punto d'inizio main come global
main:	mov r1, #10 @carica il primo operando
	mov r2, #15 @carica il secondo operando
	add r0 , r1, r2 @ esegue la somma
	mov pc, lr @ritorna il controllo al sistema operativo