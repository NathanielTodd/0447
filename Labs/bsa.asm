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
yinput:
	addi $v0, $zero, 4
	la $a0, y
	syscall			#y msg
	addi $v0, $zero, 5
	syscall			#prompting y
	add $t1, $zero, $v0		#storing y

	addi $s4, $s4, 1		#incrementing counter2
	beq $s4, $s7, outer		#whlie counter2<32 loop
	srlv $s5, $s2, $s4		#shift by counter2
	andi $s5, $s5, 1		#extracting bit
	beq $s5, $zero, inner	#looping if bit=0
	sllv $s6, $s2, $s4		#shifting number by counter
	add $s1, $s6, $s1		#adding shifted numbe
	j inner			#repeating to finish mult.