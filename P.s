.data

# E : entrée
# S : sortie
	RetourChariot: .asciiz "\n"
	E_TailleLaby: .asciiz "Taille du labyrinthe : "
	
.text
.globl main

main:
	jal CreationTableau
	j Exit

#########################################################
Exit:
	li $v0 10
	syscall
#########################################################

CreationTableau:
	la $a0 E_TailleLaby
	li $v0 4
	syscall
	
	li $v0 5
	syscall              # Lecture de la taille du labyrinthe
	
	move $a1 $a0         # Stockage de la taille du labyrinthe 
	mul $t1 $a0 $a0      # Calcul du nombre d'entiers dans le tableau
	li $t0 4             # Les entiers sont stockés sur 4 octets
	mul $a0 $t1 $t0      # Calcul de la taille du tableau en octets
 
	li $v0 9             # Création du tableau
	
	move $t3 $v0         # Stockage de l'adresse du tableau
	li $t0 0

# $a1 : Taille du labyrinthe
# $t0 : Compteur
# $t1 : Taille du tableau
# $t2 : Taille du tableau en octets
# $t3 : Adresse du tableau
	FOR_debut:
		beq $t0 $t2 FOR_fin  # Condition d'arrêt quand le tableau est rempli
		addu $t4 $t3 $t0     # Calcul de l'adresse de la case courante du tableau
		li $t5 15            # Valeur à mettre dans toutes les cases du tableau
		sw $t5 0($t4)        # Remplissage des cases du tableau
		addu $t0 $t0 4       # Incrémetation du compteur
    	j FOR_debut
    FOR_fin:
    	jr $ra