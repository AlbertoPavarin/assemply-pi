.text
.global find_max

@ Input:
@	* r0: indirizzo di memoria del vettore di interi con segno;
@	* r1: numeri di elementi del vettore;

@ Output:
@	* r0: il valor massimo del vettore;

find_max:
	@@@ istruzioni della funzione max
	push {r2-r4}
	ldr r2, [r0] @ prendo il primo numero
	mov r3, #1 @ contatore del for
loop:	ldr r4, [r0, r3, lsl #2]
	cmp r2, r4
	movlt r2, r4
	add r3, r3, #1 @ r3 += 1
	cmp r3, r1
	bne loop @ ripete se il contatore e' diverso 200
	mov r0, r2
	pop {r2-r4}
	mov pc, lr @ ritorna alla funzione chiamante
