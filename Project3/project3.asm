.text
_main:
	addi $v0, $zero, 30		#getting system time
	syscall
	add $a1, $zero $a0		#moving lower 32 bits to $a1 for seed
	addi $a0, $zero, 0		#setting generator ID
	addi $v0, $zero, 40		#generator creation
	syscall

	jal _set			#setting the characters of the matrix

				#_new just adds a high color to an empty column
	go:			#looping the new and color change
	jal _new			#all comments for change1-4 is contained in change1
	jal _change1		#the only difference between the methods are the columns they alter
	jal _change2		#change1 starts at col 0
	jal _change2		#change2 starts at col 1
	jal _change2		#change3 starts at col 3
	jal _change3		#change4 starts at col 4
	jal _change3		#they then increment the colors on every fourth column
	jal _change3
	jal _change3
	jal _change4
	jal _change4
	jal _change4
	jal _change4
	j go
	
	addi $v0, $zero, 10		#end program
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

	addi $t0, $zero, 0xffff8000	#base address
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
	addi $t0, $zero, 0xffff8000	#base address
	addi $t2, $zero, 0x002200	#low color

	addi $a0, $zero, 80		#max column	

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
	addi $t0, $zero, 0xffff8000		#base address
	addi $t1, $t0, 12480		#address of bottom of column
	addi $t2, $zero, 0x002200		#low color
	addi $t3, $zero, 0x00ee00		#second highest color
	addi $t4, $zero, 16777215		#extracting color bits
	addi $t5, $zero, 0xffffb1f0		#ending address
	
	color1:				
	lw $t6, 0($t0)			#loading word
	and $t6, $t6, $t4			#extracting color
	bne $t6, $t2, scolor1		#subtracting if not at base color
	subbed1:	
	beq $t0, $t1, complete11		#seeing if we've reached the end of the column
	addi $t0, $t0, 320			#incrementing to next row
	j color1
	
	scolor1:
	addi $t6, $t6, -4352		#decrementing color
	lw $t7, 0($t0)			#loading word from address
	andi $t7, $t7, 0xff000000		#extracting raw character
	or $t7, $t7, $t6			#adding color
	sw $t7, 0($t0)			#saving word
	bne $t6, $t3, subbed1		#seeing we changed the leading character
	beq $t0, $t1, complete11		#seeing if we have reached the end of the column
	addi $t0, $t0, 320			#incrementing to leading character
	lw $t6, 0($t0)			#loading character
	ori $t6, $t6, 0x00ff00		#setting to high
	sw $t6, 0($t0)			#saving word
	j subbed1
	
		
	complete11:
	beq $t0, $t5, complete12
	addi $t0, $t0, -12464
	addi $t1, $t1, 16
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
_change2:
	addi $t0, $zero, 0xffff8004
	addi $t1, $t0, 12480		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t3, $zero, 0x00ee00
	addi $t4, $zero, 16777215		#extracting color bits
	addi $t5, $zero, 0xffffb1f4
	
	color2:
	lw $t6, 0($t0)
	and $t6, $t6, $t4
	bne $t6, $t2, scolor2
	subbed2:
	beq $t0, $t1, complete21
	addi $t0, $t0, 320
	j color2
	
	scolor2:
	addi $t6, $t6, -4352
	lw $t7, 0($t0)
	andi $t7, $t7, 0xff000000
	or $t7, $t7, $t6
	sw $t7, 0($t0)
	bne $t6, $t3, subbed2
	beq $t0, $t1, complete21
	addi $t0, $t0, 320
	lw $t6, 0($t0)
	ori $t6, $t6, 0x00ff00
	sw $t6, 0($t0)
	j subbed2
	
		
	complete21:
	beq $t0, $t5, complete22
	addi $t0, $t0, -12464
	addi $t1, $t1, 16
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
	jr $ra
_change3:
	addi $t0, $zero, 0xffff8008
	addi $t1, $t0, 12480		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t3, $zero, 0x00ee00
	addi $t4, $zero, 16777215		#extracting color bits
	addi $t5, $zero, 0xffffb1f8
	
	color3:
	lw $t6, 0($t0)
	and $t6, $t6, $t4
	bne $t6, $t2, scolor3
	subbed3:
	beq $t0, $t1, complete31
	addi $t0, $t0, 320
	j color3
	
	scolor3:
	addi $t6, $t6, -4352
	lw $t7, 0($t0)
	andi $t7, $t7, 0xff000000
	or $t7, $t7, $t6
	sw $t7, 0($t0)
	bne $t6, $t3, subbed3
	beq $t0, $t1, complete31
	addi $t0, $t0, 320
	lw $t6, 0($t0)
	ori $t6, $t6, 0x00ff00
	sw $t6, 0($t0)
	j subbed1
	
		
	complete31:
	beq $t0, $t5, complete32
	addi $t0, $t0, -12464
	addi $t1, $t1, 16
	j color1
	complete32:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	jr $ra
_change4:
	addi $t0, $zero, 0xffff800c
	addi $t1, $t0, 12480		#address of bottom of column
	addi $t2, $zero, 0x002200
	addi $t3, $zero, 0x00ee00
	addi $t4, $zero, 65280		#extracting color bits
	addi $t5, $zero, 0xffffb1fc
	
	color4:
	lw $t6, 0($t0)
	and $t6, $t6, $t4
	bne $t6, $t2, scolor4
	subbed4:
	beq $t0, $t1, complete41
	addi $t0, $t0, 320
	j color4
	
	scolor4:
	addi $t6, $t6, -4352
	lw $t7, 0($t0)
	andi $t7, $t7, 0xff000000
	or $t7, $t7, $t6
	sw $t7, 0($t0)
	bne $t6, $t3, subbed4
	beq $t0, $t1, complete41
	addi $t0, $t0, 320
	lw $t6, 0($t0)
	ori $t6, $t6, 0x00ff00
	sw $t6, 0($t0)
	j subbed4
	
		
	complete41:
	beq $t0, $t5, complete42
	addi $t0, $t0, -12464
	addi $t1, $t1, 16
	j color1
	complete42:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	jr $ra
