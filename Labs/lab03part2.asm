.data
	calc:	.asciiz "x^y calculator\n"
	x:	.asciiz "Please enter x: "
	y:	.asciiz "Please enter y: "
	carrot:	.asciiz "^"
	equal:	.asciiz " = "
	errmsg:	.asciiz "Integers must be nonnegative.\n"
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
	add $s1, $zero, $t3		#counter1 = 1
	add $s3, $zero, $t0		#sum = x
outer:
	add $s0, $zero, $s3
	add $s3, $zero, $zero
	beq $s1, $t1, answer	#while counter1<y loop
	addi $s1, $s1, 1		#increment counter 1
	addi $s2, $zero, 0		#counter 2 = 0
inner:
	beq $s2, $t0, outer		#while counter2<x loop
	add $s3, $s3, $s0		#addition
	addi $s2, $s2, 1		#counter2 increment
	j inner	
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
		
	
