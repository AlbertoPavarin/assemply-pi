.text

@ bsearch effettua una ricerca binaria in un vettore ordinato di interi con segno
@ I parametri di input sono passati tramite stack nel seguente ordine: 
@ indirizzo del vettore, indice primo elemento, indice ultimo elemento, valore da cercare
@ L'output viene posizionato in r0: -1 se l'elemento non esiste; la posizione se l'elemento esiste
.global bsearch

 
bsearch: 
	push {fp, lr}		@ salva copia di lr, fp
	mov fp, sp		@ crea nuovo frame pointer
	add sp, sp, #-4		@ alloca una variabile locale tmp
	push {r1-r3}		@ salva copia dei registri r1-r3
	ldr r2, [fp, #12]	@ recupera j
	ldr r1, [fp, #16]	@ recupera i
	cmp r2,r1		@ confronta i e j (se j<i, allora array vuoto)
	bge full_vect		@ se j>=i, array non vuoto; salta a full_vect
				
	mov r0, #-1		@ array vuoto, quindi elemento key non trovato; ritorna -1 in r0
	b bs_exit 		@ salta alla fine

full_vect:
	add r0, r1, r2		@ calcola r0 = i+j
	asr r0, r0, #1		@ calcolra r0 = (i+j)/2
	str r0, [fp, #-4]	@ salva indice metà in memoria (variabile temp)
	ldr r3, [fp, #8]	@ recupera key
	ldr r4, [fp, #20]	@ recupera indirizzo V
	lsl r0, r0, #2		@ calcola offset r0 = r0*4 	
	ldr r0, [r4, r0]	@ recupera V[(i+j)/2)]
	cmp r0, r3		@ confronta V[(i+j)/2] e key
	bne no_key		@ se non uguali, salta a no_key
	
	ldr r0, [fp, #-4]	@ altrimenti trovato, salva indirizzo in temp in r0
	b bs_exit		@ salta alla fine

no_key:				@ ricerca ricorsiva	
	blt right_search	@ se V[(i+j)/2]>key, salta a right_search (cerca a destra)
				@ cerca a sinistra: prepara input per chiamata ricorsiva
	push {r4}		@ inserisci indirizzo V nello stack
	push {r1}		@ inserisci estremo sinistro i nello stack
	ldr r0, [fp, #-4]	@ ricarica in r0=(i+j)/2
	sub r0, r0, #1 		@ calcola (i+j)/2-1
	push {r0}		@ inserisci estremo destro (i+j)/2-1 nello stack
	push {r3}		@ inserisci key nello stack
	bl bsearch		@ chiamata ricorsiva
	add sp, sp, #16		@ rimuovi parametri chiamata ricorsiva
	b bs_exit		@ salta alla fine

right_search:
	push {r4}		@ inserisci indirizzo V nello stack
	ldr r0, [fp, #-4]	@ ricarica in r0=(i+j)/2
	add r0, r0, #1 		@ calcola (i+j)/2+1
	push {r0}		@ inserisci estremo sinistro (i+j)/2+1 nello stack
	push {r2}		@ inserisci estremo destro j nello stack
	push {r3}		@ inserisci key nello stack
	bl bsearch		@ chiamata ricorsiva
	add sp, sp, #16		@ rimuovi parametri chiamata ricorsiva

bs_exit:
	pop {r1-r3}		@ recupera valore iniziale di r1-r3
	mov sp, fp		@ rimuovi freme pointer (inclusa variabile locale)
	pop {fp, lr}		@ recupera valori iniziali di fp e lr
	mov pc, lr		@ ritorna alla funzione chiamante
