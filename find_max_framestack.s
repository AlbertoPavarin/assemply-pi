.text
.global find_max

@ Input:
@	* r0: indirizzo di memoria del vettore di interi con segno;
@	* r1: numeri di elementi del vettore;

@ Output:
@	* r0: il valor massimo del vettore;

find_max:
	@@@ istruzioni della funzione max
	push {fp, lr} @ salvo il valore lr e fp nello stack
    mov fp, sp @ aggiorno il valore di fp
	sub sp, sp, #12

	ldr r0, [fp, #12]
	ldr r2, [r0] @ prendo il primo numero
	ldr r1, [fp, #8]
	mov r3, #1 @ contatore del for
loop:
    ldr r4, [r0, r3, lsl #2]
	cmp r2, r4
	movlt r2, r4
	add r3, r3, #1 @ r3 += 1
	cmp r3, r1
	bne loop @ ripete se il contatore e' diverso 200
	mov r0, r2

	mov sp, fp
	pop {fp, pc}

	@ mov pc, lr @ ritorna alla funzione chiamante
