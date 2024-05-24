.data
n: .word 25  @ Numero di elementi nell'array V
V: .word 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1  @ Array di valori

.global main
main:
    @ Salva i registri modificati
    push {r0-r3, r10, lr}

    mov r1, #1  @ Imposta il primo LED come acceso
    bl set_gpio  @ Inizializza la GPIO
    bl write_led  @ Accende il primo LED di default, usando il valore di r1

    ldr r2, =n  @ Carica l'indirizzo di 'n' in r2
    ldr r2, [r2]  @ Carica il valore di 'n' (15) in r2

    ldr r10, =V  @ Carica l'indirizzo dell'array V in r10

loop:
    bl read_buttons  @ Legge lo stato dei pulsanti
    cmp r0, #1  @ Verifica se è premuto il pulsante destro (dx)
    moveq r1, r1, ror #1  @ Se il pulsante dx è premuto, ruota r1 verso destra di 1 bit

    cmp r1, #0  @ Verifica se r1 è uguale a 0
    blt dx  @ Se r1 è minore di 0, salta all'etichetta dx

    cmp r0, #2  @ Verifica se è premuto il pulsante sinistro (sx)
    moveq r1, r1, ror #31  @ Se il pulsante sx è premuto, ruota r1 verso sinistra di 1 bit

    cmp r1, #15  @ Verifica se r1 è maggiore di 15
    bgt sx  @ Se r1 è maggiore di 15, salta all'etichetta sx

    cmp r2, #0  @ Verifica se r2 è uguale a 0
    beq end  @ Se r2 è uguale a 0, salta all'etichetta end

ret:
    mov r0, r1  @ Copia il valore di r1 in r0
    bl write_led  @ Aggiorna i LED con il valore di r0
    b loop  @ Torna all'inizio del loop

    @ Ripristina i registri modificati
    pop {r0, r1, lr}
    @ Termina il programma e ritorna dalla funzione main
    mov pc, lr

sx:
    cmp r1, #32  @ Verifica se r1 è minore di 32
    blt ret  @ Se r1 è minore di 32, salta all'etichetta ret
    mov r1, #1  @ Imposta r1 a 1
    b ret  @ Salta all'etichetta ret

dx:
    mov r1, #8  @ Imposta r1 a 8
    b ret  @ Salta all'etichetta ret

end:
    pop {r0-r3, r10, lr}  @ Ripristina i registri salvati
    mov pc, lr  @ Termina il programma e ritorna dalla funzione main

read_buttons:
    push {r3, lr}  @ Salva il registro link
    mov r0, #0  @ Inizializza r0 a 0
    ldr r3, =n  @ Carica l'indirizzo di 'n' in r3
    ldr r3, [r3]  @ Carica il valore di 'n' (15) in r3
    sub r3, r3, r2  @ Calcola l'indice corrente dell'array V
    ldr r3, [r10, r3, lsl #2]  @ Carica il valore corrente di V nell'indice calcolato in r3
    mov r0, r3  @ Copia il valore di r3 in r0
    sub r2, r2, #1  @ Decrementa r2 di 1
    pop {r3, lr}  @ Ripristina il registro link
    mov pc, lr  @ Ritorna dalla funzione

set_gpio:
    push {lr}  @ Salva il registro link
    mov r10, #1  @ Imposta r10 a 1 (dummy operation per l'inizializzazione della GPIO)
    pop {lr}  @ Ripristina il registro link
    mov pc, lr  @ Ritorna dalla funzione

read_slides:
    push {r6-r9, lr}  @ Salva i registri modificati
    mov r0, #0  @ Inizializza r0 a 0

    @ Maschera i bit per conservare solo i primi 4 bit meno significativi dei registri
    and r6, r6, #0x1  @ R6 ora contiene solo il primo bit meno significativo
    and r7, r7, #0x1  @ R7 ora contiene solo il primo bit meno significativo
    and r8, r8, #0x1  @ R8 ora contiene solo il primo bit meno significativo
    and r9, r9, #0x1  @ R9 ora contiene solo il primo bit meno significativo

    cmp r6, #1
    addeq r0, r0, #1  @ Se il bit meno significativo di R6 è 1, aggiungi 1 a r0

    cmp r7, #1
    addeq r0, r0, #2  @ Se il bit meno significativo di R7 è 1, aggiungi 2 a r0

    cmp r8, #1
    addeq r0, r0, #4  @ Se il bit meno significativo di R8 è 1, aggiungi 4 a r0

    cmp r9, #1
    addeq r0, r0, #8  @ Se il bit meno significativo di R9 è 1, aggiungi 8 a r0

    pop {r6-r9, lr}  @ Ripristina i registri salvati
    mov pc, lr  @ Ritorna dalla funzione

write_led:
    push {r1, lr}  @ Salva il registro r1 e il registro link

    and r1, r1, #0xF  @ Maschera r1 per conservare solo i primi 4 bit meno significativi

    @ Sposta e isola i primi 4 bit nei rispettivi registri
    mov r6, r1  @ Copia r1 in r6 per isolamento del bit 0
    and r6, r6, #1  @ Maschera tutti i bit eccetto il bit meno significativo di r6

    mov r7, r1  @ Copia r1 in r7 per isolamento del bit 1
    lsr r7, r7, #1  @ Sposta il bit 1 di r1 al bit meno significativo di r7
    and r7, r7, #1  @ Maschera tutti i bit eccetto il bit meno significativo di r7

    mov r8, r1  @ Copia r1 in r8 per isolamento del bit 2
    lsr r8, r8, #2  @ Sposta il bit 2 di r1 al bit meno significativo di r8
    and r8, r8, #1  @ Maschera tutti i bit eccetto il bit meno significativo di r8

    mov r9, r1  @ Copia r1 in r9 per isolamento del bit 3
    lsr r9, r9, #3  @ Sposta il bit 3 di r1 al bit meno significativo di r9
    and r9, r9, #1  @ Maschera tutti i bit eccetto il bit meno significativo di r9

    pop {r1, lr}  @ Ripristina il registro r1 e il registro link
    mov pc, lr  @ Ritorna dalla funzione
