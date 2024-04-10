.data
addr_n: .word 10	@ Word in memoria con il valore di n 

.bss
addr_sum: .skip 4	@ Word in memoria dove salvare il valore finale

.text
.global main

main:	mov r0,#0	@ somma parziale
	mov r1,#1	@ contatore del for
	mov r2,#0	@ contiene il quadrato calcolato in ogni iterazione (r2 = r1*r1)
	ldr r4,=addr_n
	ldr r3,[r4]	@ contiene il valore di n
	ldr r5,=addr_sum

loop:	mul r2, r1, r1	@ i^2
	add r0, r0, r2	@ n = n + i^2
	add r1, r1, #1 	@ i++
	cmp r1, r3	@ if(r1 == r3)
	bls loop	@ ripeto

	@@@ Parte finale del programma
	str r0, [r5]
   	mov pc, lr