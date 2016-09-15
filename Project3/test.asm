.data
	
.text
	addi $v0, $zero, 30	#getting system time
	syscall
	add $a1, $zero $a0	#moving lower 32 bits to $a1 for seed
	addi $a0, $zero, 0	#setting generator ID
	addi $v0, $zero, 40	#adding 40 for generator creation syscall
	syscall

	addi $a0, $zero, 100

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal _random		#getting random character
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall

	addi $v0, $zero, 10
	syscall

_random:

	add $a1, $zero, $a0
	add $a0, $zero, $zero
	addi $v0, $zero, 42         	#random int
	xor $a0, $a0, $a0 	 	# Select random generator 0
	syscall            		# Generate random int (returns in $a0)
	
	add $v0, $zero, $a0		#returning random int

	jr $ra
_change2:
	addi $t0, $zero, 0xffff8004
	addi $t1, $t0, 9360		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t4, $zero, 16777215	#extracting color bits
	addi $t6, $zero, 0xffffa5c0
	
	color2:
	lw $t3, 0($t0)
	and $t3, $t3, $t4
	bne $t3, $t2, scolor2
	j check2
	checked2:
	lw $t8, 0($t0)
	andi $t8, $t8, 0xff000000
	or $t8, $t8, $t3
	sw $t8, 0($t0)
	beq $t0, $t1, complete21
	addi $t0, $t0, 240
	
	j color2
	
	scolor2:
	addi $t3, $t3, -4352
	j checked2
	
	check2:
	addi $t0, $t0, -240
	slt $t7, $t0, $t6
	addi $t0, $t0, 240
	bne $t7, $zero, checked2
	lw $t5, 0($t0)	
	and $t5, $t5, $t4
	beq $t5, $t2, checked2
	addi $t5, $zero, 0x00ff00
	j checked2
	
	complete21:
	beq $t0, $t6, complete22
	addi $t0, $t0, 9340
	addi $t1, $t1, 20
	j color1
	complete22:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	jr $ra
_change3:
	addi $t0, $zero, 0xffff8008
	addi $t1, $t0, 9360		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t4, $zero, 16777215	#extracting color bits
	addi $t6, $zero, 0xffffa5c4
	
	color3:
	lw $t3, 0($t0)
	and $t3, $t3, $t4
	bne $t3, $t2, scolor3
	j check3
	checked3:
	lw $t8, 0($t0)
	andi $t8, $t8, 0xff000000
	or $t8, $t8, $t3
	sw $t8, 0($t0)
	beq $t0, $t1, complete31
	addi $t0, $t0, 240
	
	j color3
	
	scolor3:
	addi $t3, $t3, -4352
	j checked3
	
	check3:
	addi $t0, $t0, -240
	slt $t7, $t0, $t6
	addi $t0, $t0, 240
	bne $t7, $zero, checked3
	lw $t5, 0($t0)	
	and $t5, $t5, $t4
	beq $t5, $t2, checked3
	addi $t5, $zero, 0x00ff00
	j checked3
	
	complete31:
	beq $t0, $t6, complete32
	addi $t0, $t0, 9340
	addi $t1, $t1, 20
	j color3
	complete32:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	jr $ra
_change4:
	addi $t0, $zero, 0xffff800c
	addi $t1, $t0, 9360		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t4, $zero, 16777215	#extracting color bits
	addi $t6, $zero, 0xffffa5c8
	
	color4:
	lw $t3, 0($t0)
	and $t3, $t3, $t4
	bne $t3, $t2, scolor4
	j check4
	checked4:
	lw $t8, 0($t0)
	andi $t8, $t8, 0xff000000
	or $t8, $t8, $t3
	sw $t8, 0($t0)
	beq $t0, $t1, complete41
	addi $t0, $t0, 240
	
	j color4
	
	scolor4:
	addi $t3, $t3, -4352
	j checked4
	
	check4:
	addi $t0, $t0, -240
	slt $t7, $t0, $t6
	addi $t0, $t0, 240
	bne $t7, $zero, checked4
	lw $t5, 0($t0)	
	and $t5, $t5, $t4
	beq $t5, $t2, checked4
	addi $t5, $zero, 0x00ff00
	j checked4
	
	complete41:
	beq $t0, $t6, complete42
	addi $t0, $t0, 9340
	addi $t1, $t1, 20
	j color4
	complete42:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	jr $ra
_change5:
	addi $t0, $zero, 0xffff8010
	addi $t1, $t0, 9360		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t4, $zero, 16777215	#extracting color bits
	addi $t6, $zero, 0xffffa5cc
	
	color5:
	lw $t3, 0($t0)
	and $t3, $t3, $t4
	bne $t3, $t2, scolor5
	j check5
	checked5:
	lw $t8, 0($t0)
	andi $t8, $t8, 0xff000000
	or $t8, $t8, $t3
	sw $t8, 0($t0)
	beq $t0, $t1, complete51
	addi $t0, $t0, 240
	
	j color5
	
	scolor5:
	addi $t3, $t3, -4352
	j checked5
	
	check5:
	addi $t0, $t0, -240
	slt $t7, $t0, $t6
	addi $t0, $t0, 240
	bne $t7, $zero, checked5
	lw $t5, 0($t0)	
	and $t5, $t5, $t4
	beq $t5, $t2, checked5
	addi $t5, $zero, 0x00ff00
	j checked5
	
	complete51:
	beq $t0, $t6, complete52
	addi $t0, $t0, 9340
	addi $t1, $t1, 20
	j color1
	complete52:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	jr $ra
