.global _start @ Questa direttiva definisce il simbolo _start come globale. _start è il punto di ingresso del programma
_start:
	ldr r1, =A @ Carica l'indirizzo della posizione di memoria A nel registro r1.
			   @ L'istruzione ldr (load) carica un valore dalla memoria nell'architettura ARM.

	mov r0, #0xA0 @ Carica il valore immediato 0xA0 nel registro r0.
				  @ L'istruzione mov (move) assegna un valore diretto a un registro.

@ A: Questa è un'etichetta che indica il punto di destinazione per il salto. È utilizzato nell'istruzione di caricamento successiva.
A:	sub r0, r0, #2 @ Sottrae il valore immediato 2 dal contenuto del registro r0.
				   @ Quindi, il contenuto di r0 diventa il valore originale di r0 meno 2.

	ldr r2, [r1] @ Carica il valore dalla posizione di memoria indicata dal contenuto del registro r1 nel registro r2.
	str r2, [pc] @ Memorizza il contenuto del registro r2 nell'indirizzo di memoria puntato dal registro del programma (pc).
	             @ pc è il registro del programma che contiene l'indirizzo dell'istruzione successiva da eseguire.

	sub r1, r0, r0 @ Sottrae il contenuto del registro r0 dal registro r1 e il risultato viene memorizzato in r1.
	               @ Questa operazione può essere utilizzata per effettuare una copia di registro o una sottrazione tra due registri.