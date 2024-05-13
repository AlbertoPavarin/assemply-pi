.text
@ Semplice funzione che calcola (r0+r1)^2 e salva il risultato in r0
sum_square:
    push {r2}   @ salvo i registri usati
	add r2, r0, r1
	mul r0, r2, r2
    pop {r2}    @ ripristino i registri usati
	mov pc, lr      @ termina sum_square

.global main
main:
    push {r0, r1, lr}   @ salvo i registri usati
    mov r0, #5
	mov r1, #3
	bl sum_square
	nop
    pop {r0, r1, lr}    @ ripristino i registri usati
	mov pc, lr          @ termina main
