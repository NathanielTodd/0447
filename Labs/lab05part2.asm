.data
	exc:	.asciiz		"! = "
	enter: 	.asciiz		"Enter a nonnegative integer: "
	wrong:	.asciiz		"Invalid integer; try again.\n"
	
.text
j input
einput:
	la $a0, wrong
	addi $v0, $zero, 4
	syscall			#display incorrect input message
input:
	la $a0, enter
	addi $v0, $zero, 4
	syscall			#displaying ipnut message

	addi $v0, $zero, 5
	syscall			#getting integer
	slt $t1, $v0, $zero
	bne $t1, $zero, einput	#testing for correct input
	add $a0, $zero, $v0		#putting the integer in a0
	
	add $v0, $zero, 1
	syscall			#printing the integer
	
	add $s0, $zero, $a0		#moving the integer into s0 temporarily
	
	la $a0, exc		
	add $v0, $zero, 4
	syscall			#displaying ! =
	
	add $a0, $zero, $s0		#putting integer back into a0
	
	jal _Fac	
	
	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall			#displaying answer
	
	add $v0, $zero, 10
	syscall			#end program
	
_Fac:

	beq $a0, $zero, return	#jumping to return 1 if zero is reached

	addi $sp, $sp, -8		#storing numbers in stack
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	addi $a0, $a0, -1
	jal _Fac
	lw $ra, 4($sp)		#restoring values from stack
	lw $a0, 0($sp)
	addi $sp, $sp, 8

	add $s0, $zero, $zero
	add $s1, $zero, $zero
	loopm:			#multiplying
	add $s0, $s0, $a0
	addi $s1, $s1, 1
	bne $s1, $v0, loopm
	add $v0, $zero, $s0
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	
	jr $ra
		
	return:
	addi $v0, $zero, 1
	jr $ra
