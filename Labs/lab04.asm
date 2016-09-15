.data
	buffer:	.space	64
	obuffer:  .space	64
	enter:	.asciiz	"Please enter a string:\n"
	size:	.asciiz 	"The string has "
	charac:	.asciiz	" characters.\n"
	start:	.asciiz	"Specify start index: "
	end:	.asciiz	"Specify end index: "
	sub:	.asciiz	"Your substring is: \n"
.text

main:

	la $a0, enter
	addi $v0, $zero, 4
	syscall			#printing prompt message

	la $a0, buffer 		#loading buffer address for string
	addi $a1, $zero, 64		#giving user 64 characters of input
	jal _readString

	la $a0, buffer		#putting the returned address into a0
	jal _strLength		#calling strLength function
	add $s0, $zero, $v0		#storing return integer
	la $a0, size
	addi $v0, $zero, 4
	syscall			#printing size string
	add $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall			#printing stored returned integer
	la $a0, charac
	addi $v0, $zero, 4
	syscall			#printing charac string.

	la $a0, start
	addi $v0, $zero, 4
	syscall			#printing start message
	addi $v0, $zero, 5
	syscall			#reading integer
	add $a2, $zero, $v0		#storing start index integer
	la $a0, end
	addi $v0, $zero, 4
	syscall			#printing end message
	addi $v0, $zero, 5
	syscall			#reading integer
	add $a3, $zero, $v0		#storing end index integer
	la $a0, buffer		#address of input string
	la $a1, obuffer		#address of output buffer
	jal _subString		#calling _substring

	la $a0, sub
	addi $v0, $zero, 4
	syscall			#printing sub string message
	la $a0, obuffer
	addi $v0, $zero, 4
	syscall			#printing substring

	addi $v0, $zero, 10
	syscall			#ending program
	
	
_strLength:

	add $t0, $zero, $zero	#setting counter to 0
	add $t2, $zero, $a0
	loop:
		lb $t1, 0($t2)		#load the next character into t1
		beq $t1, $zero, exit	#testing for null	
		addi $t2, $t2, 1		#increment string pointer
		addi $t0, $t0, 1		#increment the counter
		j loop			#looping
	exit:
	add $v0, $zero, $t0		#putting t0 into v0 for return convention
	jr $ra			#return to address


_readString:
	
	addi $v0, $zero, 8
	syscall			#asking for input

	addi $sp, $sp, -4	
	sw $ra, 0($sp)		#storing return address
	jal _strLength		
	lw $ra, 0($sp)		#loading return address
	addi $sp, $sp, 4		

	la $a0, buffer		#putting the address of string into a0
	add $a0, $a0, $v0
	addi $a0, $a0, -1
	sb $0, 0($a0)		#replacing the null character

	jr $ra			

_subString:
	
	addi $sp, $sp, -4	
	sw $ra, 0($sp)		#storing return address
	jal _strLength		
	lw $ra, 0($sp)		#loading return address
	addi $sp, $sp, 4

	addi $t8, $zero, -1
	slt $t0, $a2, $a3		#exit if end index is less than start index
	beq $t0, $zero, exit1
	slt $t0, $a3, $v0		#exit if end index is greater than length of string
	beq $t0, $zero, exit1
	slt $t0, $t8, $a3		#exit if end index is less than zero
	beq $t0, $zero, exit1
	slt $t0, $t8, $a2		#exit if start index is less than zero
	beq $t0, $zero, exit1

	add $t0, $a0, $a2		#adding start index to string address
	add $t1, $a0, $a3		#adding end index to string address
	loop1:
		beq $t0, $t1, exit2		#test if we have reached end index
		lb $t3, 0($t0)		#load byte into t3
		sb $t3, 0($a1)		#save byte into adress in a1
		addi $t0, $t0, 1		#increment address of address of string to next byte
		addi $a1, $a1, 1		#increment address of where to save
		j loop1
	exit1:
		sb $0, 0($a1)
	exit2:
		jr $ra

