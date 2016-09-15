.data

	names:		.asciiz "steve", "john", "chelsea", "julia", "ryan"
	ages:		.byte 20, 25, 22, 21, 23
	uinput: 	.asciiz "Please enter a name: "
	buffer:		.space 64
	nf:		.asciiz "Not Found!"
	ai:		.asciiz "Age is: "
	

.text

	la $a0, uinput
	addi $v0, $zero, 4
	syscall				#displaying uinput

	la $a0, buffer			
	addi $a1, $zero, 64
	addi $v0, $zero, 8
	syscall				#getting string
	

	nloop:				#removing newline character
	lb $t0, 0($a0)
	addi $a0, $a0, 1
	bne $t0, $zero, nloop
	addi $a0, $a0, -2
	sb $zero, 0($a0)
	la $a0, buffer

	add $t0, $zero, $zero		#index counter
	addi $t5, $zero, 5		
	la $a0, names
	la $a1, buffer
	
	iloop:				#testing string
	beq $t0, $t5, done
	jal _StrEqual
	bne $v0, $zero, done1
	addi $t0, $t0, 1		#incrementing index
	la $a1, buffer			#reseting input string address
	addi $a0, $a0, 1		#incrementing address to next index
	j iloop
	
_StrEqual:
	
	eloop:				#testing each byte for equality
	lb $s0, 0($a0)
	lb $s1, 0($a1)
	bne $s0, $s1, nend		#go to nend if they are not equal
	beq $s0, $zero, end		#if they are equal and you've hit the end of the string go to end
	addi $v0, $zero, 1		#setting v0 to 1 because all bytes are equal thus far
	addi $a0, $a0, 1		#incrementing
	addi $a1, $a1, 1
	j eloop

	nend:
	add $v0, $zero, $zero		#setting v0 to 0 because they are not equal
	lb $s0, 0($a0)			#setting the address to the null character
	beq $s0, $zero, end
	addi $a0, $a0, 1
	j nend
	end:
	jr $ra
	
done:
	la $a0, nf
	addi $v0, $zero, 4
	syscall				#displaying message
	
	addi $v0, $zero, 10
	syscall				#terminating program
	
done1:
	la $a0, ai
	addi $v0, $zero, 4
	syscall				#displaying messsage
	
	la $a0, ages
	add $a1, $zero, $t0
	jal _LookUpAge
	
	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall
	
	addi $v0, $zero, 10
	syscall				#termintating program
	
_LookUpAge:

	add $a0, $a0, $a1		#adding index to address
	lb $s0, 0($a0)			#loading age
	
	add $v0, $zero, $s0		#returning age
	
	jr $ra