.data 
	msg: .asciiz "Please enter your integer: "
	msg1: .asciiz "Here is the output: "

.text
	
	addi $v0, $zero, 4
	la $a0, msg
	syscall			#displaying message
	addi $v0, $zero, 5
	syscall			#prompting integer
	add $t0, $zero, $v0		#storing prompted integer

	srl $t1, $t0, 15		#shifting
	andi $t1, $t1, 7		#extracting bits

	addi $v0,$zero, 4
	la $a0, msg1
	syscall			#msg1

	addi $v0, $zero, 1	
	add $a0, $zero, $t1
	syscall			#integer answer
	