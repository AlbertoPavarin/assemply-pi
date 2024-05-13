@@@ Questo file implementa find_max utilizzando lo stack e lo stack frame; 
@@@ Inoltre i parametri di input vengono passati tramite stack

.text

.global find_max

@ Input: 
@   * r0: indirizzo in memoria del vettore di interi con segno; 
@   * r1: numero di elementi del vettore; 
@ Output:
@   * r0: il valor massimo del vettore


find_max:
	
	push {fp, lr}		@ salvataggio vecchio frame
	mov fp, sp		@ creazione nuovo frame
	 
	@ Utilizzo dei registri:
	@    R0: indirizzo del vettore
	@    R1: lunghezza del vettore (in word)
	@    R2: indice del prossimo elemento da confrontare
	@    R3: indirizzo del prossimo elemento da confrontare
	@    R4: valore minimo trovato tra i valori letti
	@    R5: prossimo valore da confrontare 

	push {r1-r5}		@ salvataggio del contenuto dei registri usatii

	ldr r0, [fp, #12]	@ indirizzo del vettore in r0
	ldr r1, [fp, #8]	@ numero di elementi del vettore in r1
	mov r2, #0		@ indice del prossimo elemento da confrontare
	mov r3, r0		@ indirizzo del prossimo elemento da confrontare
	ldr r4, [r3]		@ salva in r4 il minimo tra gli elementi letti

loop:		ldr r5, [r3]	@ carica il prossimo elemento da confrontare
		cmp r4, r5	@ confronta
		movle r4, r5	@ se r5<=r4, cambia il minimo
		add r3, r3, #4  @ incrementa il puntatore (4 byte perché gli indrizzi sono a 4 byte)
		add r2, r2, #1	@ incrementa l'indice
		cmp r1, r2	@ abbiamo letto tutto il vettore?
		bne loop	@ se no, ripeti
	
	mov r0, r4		@ mette l'output in r0
	pop {r1-r5}		@ ripristina il contenuto dei registri
	pop {fp, lr}		@ ripristino vecchio frame pointer
	mov pc, lr		@ termina la funzione e ritorna
