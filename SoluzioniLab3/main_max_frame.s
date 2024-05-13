@@@ Questo file implementa un main che crea che invoca la funzione find_max passando i parametri di input via stack

.data

n: .word 200 @ dimensione array

@ Alloca e inizializza un vettore di 200 word 
V: .word -697, 1625, -873, 1375, -158, 1162, -1590, -1971, -345, 260, -956, 1329, 784, -1003, 968, 1346, 802, 855, -1649, -1579, -1634, -75, -1027, -842, -1669, -526, 181, 904, 881, 96, 668, -1467, 1421, -1420, 166, 1119, -561, -564, 1779, 1700, -585, -1603, -1819, -514, -1740, 498, 1981, -1389, 947, 1099, 1197, -1850, -584, -325, 387, -1480, 1335, 1818, 975, 1667, 1402, 1047, -273, -1091, -46, -562, -635, -1700, -1194, 1053, 713, -1857, -1577, 1657, -1930, 1064, -278, 563, 1473, -1871, 1767, 662, 91, -1045, 110, 225, -1095, 959, -720, 690, -693, 250, -1252, -628, 1468, 502, -820, 931, 1051, 511, 522, -130, 833, 204, 1238, -1736, 1721, 978, -1475, 1472, 1788, -1870, -788, -595, 419, -824, -146, -1333, -292, 311, -1873, -994, -1518, 1631, -905, -805, 544, 1960, -128, 333, -125, 1046, -1093, -1720, 356, 524, -316, -1395, -1761, -1515, -339, -1542, -40, -245, 1058, 103, 85, 1885, 29, -762, 1146, 1449, -520, -1746, -807, -1627, 135, -1586, 415, 1746, -1738, -1370, 193, -1782, 302, -1881, 1584, 1240, -1349, 363, 566, -138, -1891, 521, -1457, -1621, 1077, -479, -1713, -846, 1908, 679, 1060, 1132, 1126, 534, -230, -670, 1461, -1698, 1129, 1272, 1299, 813, 1453, -1772, 239, 355, 850, 1388


.text
.global main

main:	
	push {r0, lr}	@ salvataggio registri
	ldr r0, =V	@ indirizzo del vettore in r0
	push {r0}	@ primo parametro di find_max
	ldr r0, =n	@ carica indirizzo n_list
	ldr r0, [r0]	@ lunghezza di list in r1
	push {r0}	@ secondo parametro di find_max
	bl find_max	@ chiama la funzione per trovare il massimo	
	add sp, sp, #8	@ rimuovo i parametri di input dallo stack
	bl print_int	@ stampa il risultato 
	pop {r0, lr}	@ ripristino valori registri
	mov pc, lr	@ esci
