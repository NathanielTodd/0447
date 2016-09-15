.text

start:

	addi $s0, $zero, 10		#value of plus
	addi $s1, $zero, 11		#value of minus
	addi $s2, $zero, 12		#value of multiplication
	addi $s3, $zero, 13		#value of division
	addi $s4, $zero, 14		#value of equals
	addi $s5, $zero, 15		#value of clear
	addi $s6, $zero, 9		#value of nine for the *10 loop
	add $t0, $zero, $zero		#operator
	add $t1, $zero, $zero		#operand 1
	add $t2, $zero, $zero		#operand 2
	add $t3, $zero, $zero		#counter
	add $t4, $zero, $zero		#extra for *10 loop
	add $t5, $zero, $zero		#extra for calculations
	add $t8, $zero, $zero		#display segment
	add $t9, $zero, $zero		#calculator input

poll:
	beq $t9, $zero, poll		#testing when button is pressed
	andi $t9, $t9, 15			#extracting input
	
	beq $t9, $s0, op
	beq $t9, $s1, op
	beq $t9, $s2, op
	beq $t9, $s3, op
	beq $t9, $s4, _equals
	beq $t9, $s5, start

	add $t3, $zero, $zero		#*10 loop
	loop:
	add $t4, $t1, $t4
	addi $t3, $t3, 1
	bne $t3, $s6, loop
	add $t1, $t4, $t9
	add $t4, $zero, $t1

	add $t8, $zero, $t1
	add $t9, $zero, $zero
	add $t5, $zero, $zero
	j poll

op:
	add $t0, $zero, $t9		#storing selected operator
	add $t9, $zero, $zero
poll2:	
	beq $t9, $zero, poll2	#testing when button is pressed
	andi $t9, $t9, 15		#extracting input

	beq $t9, $s0, _add
	#beq $t9, $s1, poll2
	#beq $t9, $s2, poll2
	#beq $t9, $s3, poll2
	beq $t9, $s4, _equals
	beq $t9, $s5, start

	add $t3, $zero, $zero		#*10 loop
	add $t4, $zero, $t2
	loop1:
	add $t4, $t2, $t4
	addi $t3, $t3, 1
	bne $t3, $s6, loop1
	add $t2, $t4, $t9
	add $t4, $zero, $t2

	add $t8, $zero, $t2	
	add $t9, $zero, $zero
	j poll2

_add:
	beq $t2, $zero, op
	add $t1, $t1, $t2
	add $t8, $zero, $t1
	add $t0, $zero, $zero
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j poll2
_sub:
	
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j poll2
_mult:
	
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j poll2
_div:
	
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j poll2
_equals:
	
	add $t5, $zero, $t9
	beq $t0, $s0, _add
	beq $t0, $s1, _sub
	beq $t0, $s2, _mult
	beq $t0, $s3, _div
	
	add $t8, $zero, $t1	
	j start1
_reset:
	add $t1, $zero, $t9
	j poll
