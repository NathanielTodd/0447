.text
_main:
	addi $v0, $zero, 30	#getting system time
	syscall
	add $a1, $zero $a0	#moving lower 32 bits to $a1 for seed
	addi $a0, $zero, 0	#setting generator ID
	addi $v0, $zero, 40	#generator creation
	syscall

	jal _set
	
	go:
	jal _new
	jal _change1
	jal _change1
	j go
	
	addi $v0, $zero, 10
	syscall	
_random:

	add $a1, $zero, $a0
	add $a0, $zero, $zero
	addi $v0, $zero, 42         	#random int
	xor $a0, $a0, $a0 	 	# Select random generator 0
	syscall            		# Generate random int (returns in $a0)
	
	add $v0, $zero, $a0		#returning random int
	add $s0, $zero, $zero

	jr $ra
_set:

	addi $t0, $zero, 0xffff8000
	addi $t1, $zero, 0x002200
	addi $t3, $zero, 0xffffb1fc
	
	loop:
	addi $a0, $zero, 94	

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal _random		#getting random character
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	add $a0 , $zero, $zero
	addi $t2, $v0, 32		#putting character into t0	
	sll $t2, $t2, 24	
	or $t2, $t1, $t2
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	beq $t0, $t3, sdone
	j loop

	sdone:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	jr $ra
_new:
	new:
	addi $t0, $zero, 0xffff8000
	addi $t2, $zero, 0x002200

	addi $a0, $zero, 80	#max column	

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal _random		#getting random character
	lw $ra, 0($sp)
	addi $sp, $sp, 4
		
	sll $t3, $v0, 2		#multiply by 4
	
	add $t0, $t0, $t3		#putting address of top of column
	addi $t1, $t0, 9360		#address of bottom of column
	addi $t5, $zero, 16777215	#extracting color bits
	
	test:
	lw $t4, 0($t0)
	and $t4, $t4, $t5
	addi $t0, $t0, 240	
	bne $t4, $t2, new
	beq $t0, $t1, valid
	j test
	valid:
	addi $t0, $zero, 0xffff8000
	sll $t3, $v0, 2		#multiply by 4
	add $t0, $t0, $t3
	lw $t6, 0($t0)
	ori $t6, $t6, 0x00ff00
	sw $t6, 0($t0)
	
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	jr $ra
_change1:
	addi $t0, $zero, 0xffff8000
	addi $t1, $t0, 12480		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t3, $zero, 0x00ee00
	addi $t4, $zero, 16777215		#extracting color bits
	addi $t5, $zero, 0xffffb1fc
	
	color1:
	lw $t6, 0($t0)
	and $t6, $t6, $t4
	bne $t6, $t2, scolor1
	subbed1:
	beq $t0, $t1, complete11
	addi $t0, $t0, 320
	j color1
	
	scolor1:
	addi $t6, $t6, -4352
	lw $t7, 0($t0)
	andi $t7, $t7, 0xff000000
	or $t7, $t7, $t6
	sw $t7, 0($t0)
	bne $t6, $t3, subbed1
	beq $t0, $t1, complete11
	addi $t0, $t0, 320
	lw $t6, 0($t0)
	ori $t6, $t6, 0x00ff00
	sw $t6, 0($t0)
	j subbed1
	
		
	complete11:
	beq $t0, $t5, complete12
	addi $t0, $t0, -12476
	addi $t1, $t1, 4
	j color1
	complete12:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	jr $ra
