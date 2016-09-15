.data
	calc:	.asciiz "x^y calculator\n"
	x:	.asciiz "Please enter x: "
	y:	.asciiz "Please enter y: "
	carrot:	.asciiz "^"
	equal:	.asciiz " = "
	errmsg:	.asciiz "Enter postive integers.\n"
.text
	addi $v0, $zero, 4
	la $a0, calc
	syscall			#calc msg
xinput:
	addi $v0, $zero, 4
	la $a0, x
	syscall			#x msg
	addi $v0, $zero, 5
	syscall			#prompting x
	add $t0, $zero, $v0 	#storing x
	slt $t2, $t0, $zero
	bne $t2, $zero, error1 	#error testing
yinput:
	addi $v0, $zero, 4
	la $a0, y
	syscall			#y msg
	addi $v0, $zero, 5
	syscall			#prompting y
	add $t1, $zero, $v0		#storing y
	slt $t2,$t1,$zero
	bne $t2,$zero, error2 	#error testing
y0:
	addi $t3, $zero, 1		#getting constant 1
	bne $t1, $zero, x0		#case of y = 0
	add $s0, $zero, $t3
	j answer
x0:
	bne $t0, $zero, x1		#case of x = 0
	add $s0, $zero, $zero
	j answer
x1:				
	bne $t0, $t3, comput	#case of x = 1
	add $s0, $zero, $t3
	j answer
comput:
	add $s1, $zero, $t0		#interm. value
	add $s2, $zero, $t0		#mult. value
	add $s3, $zero, $t3		#counter1 = 1
	addi $s7, $zero, 32		#constant 32

outer:				#loop for y exponent
	beq $s3, $t1, done		#while counter1<y loop
	addi $s3, $s3, 1		#counter 1 increment
	add $s4, $zero, $zero	#counter2 = -1

inner:				#bitwise shift and add
	addi $s4, $s4, 1		#incrementing counter2
	beq $s4, $s7, outer		#whlie counter2<32 loop
	srlv $s5, $s2, $s4		#shift by counter2
	andi $s5, $s5, 1		#extracting bit
	beq $s5, $zero, inner	#looping if bit=0
	sllv $s6, $s1, $s4		#shifting number by counter
	add $s1, $s6, $s1		#adding shifted numbe
	j inner			#repeating to finish mult.

done:
	add $s0, $zero, $s1		#putting answer in s0

answer:
	addi $v0, $zero, 1
	add $a0, $zero, $t0
	syscall			#displaying x
	addi $v0, $zero, 4
	la $a0, carrot
	syscall			#displaying ^
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall			#displaying y
	addi $v0, $zero, 4
	la $a0, equal
	syscall			#displaying =
	addi $v0, $zero, 1
	add $a0, $zero, $s0
	syscall			#displaying product
	addi $v0, $zero, 10			
	syscall			#end

error1:
	addi $v0, $zero, 4		#displaying error message
	la $a0, errmsg
	syscall
	j xinput
error2:
	addi $v0, $zero, 4		#displaying error message
	la $a0, errmsg
	syscall
	j yinput
		
	
