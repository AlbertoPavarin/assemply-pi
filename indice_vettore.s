.data                       @ Sezione dati
    .align 2                @ Allineamento su una parola (4 byte)
V:  .space 120              @ Definizione di 30 elementi da 32 bit (30 * 4 = 120 byte)

.text                       @ Sezione del codice
    .global _start          @ Dichiarazione del simbolo globale _start
_start:
	mov r0, #0x104			@ Inserisco in r0 un valore
	mov r1, #8				@ Indice i
    ldr r2, =V              @ Carica l'indirizzo base del vettore V in r2
	
	str r0, [R2, R1, LSL #2]@ Indice R1: offset R1*4
	
	@ Stessa cosa ma con più passaggi
	@lsl r3, r1, #2          @ Moltiplica l'indice i (in r1) per 4 per ottenere l'offset corretto (4 byte per ogni elemento)
    @add r2, r2, r3          @ Calcola l'indirizzo dell'elemento V[i] sommando l'indirizzo base di V (in r2) con l'offset (in r3)
    @str r0, [r2]            @ Salva il contenuto del registro r0 nell'elemento V[i]
