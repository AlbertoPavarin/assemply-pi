.global _start
_start:
    ldr r0, =v         @ Carica l'indirizzo della variabile v nell registro r0
    mov r1, #3         @ Carica il valore 3 nel registro r1
    ldrb r3, [r0, r1]  @ Carica il byte dalla posizione di memoria indicata da r0 + r1 e memorizzalo in r3

.data                  @ Sezione .data, contenente dati inizializzati
v: .byte 1,5,10,15,50  @ Definizione dell'array di byte v contenente i valori 1, 5, 10, 15, 50