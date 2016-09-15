.data
                      #    # " !       ' & % $     + * ) (     / . - ,     3 2 1 0     7 6 5 4     ; : 9 8     ? > = <     C B A @     G F E D     K J I H     O N M L     S R Q P     W V U T     [ Z Y X     _ ^ ] \     c b a `     g f e d     k j i h     0 n m l     s r q p     w v u t     { z y x     | } ~ <-
	line1:	.word	0x50502000, 0x2040c020, 0x00002020, 0x00000000, 0x70702070, 0xf870f810, 0x00007070, 0x70000000, 0x70f07070, 0x70f8f8f0, 0x88087088, 0x70888880, 0x70f070f0, 0x888888f8, 0x70f88888, 0x00207000, 0x00800020, 0x00300008, 0x80102080, 0x00000060, 0x00000000, 0x00000040, 0x10000000, 0x00404020
	line2:	.word	0x50502000, 0x20a0c878, 0x20a81040, 0x08000000, 0x88886088, 0x08888030, 0x00008888, 0x88400010, 0x88888888, 0x88808088, 0x90082088, 0x8888d880, 0x88888888, 0x88888820, 0x40088888, 0x00501080, 0x00800020, 0x00400008, 0x80000080, 0x00000020, 0x00000000, 0x00000040, 0x20000000, 0x00a82020
	line3:	.word	0xf8502000, 0x20a01080, 0x20701040, 0x10000000, 0x08082098, 0x1080f050, 0x20208888, 0x0820f820, 0x80888898, 0x80808088, 0xa0082088, 0x88c8a880, 0x80888888, 0x88888820, 0x40105050, 0x00881040, 0x70f07010, 0x70e07078, 0x903060f0, 0x70f8f020, 0x78b878f0, 0xa88888f0, 0x20f88888, 0x00102020
	line4:	.word	0x50002000, 0x00402070, 0xf8d81040, 0x2000f800, 0x301020a8, 0x20f80890, 0x00007870, 0x30100040, 0x80f088a8, 0x80f0f088, 0xc00820f8, 0x88a88880, 0x70f088f0, 0x88888820, 0x40202020, 0x00001020, 0x88880800, 0x88408888, 0xa0102088, 0x8888a820, 0x80488888, 0xa8888840, 0x40108850, 0x00001020
	line5:	.word	0xf8002000, 0x00a84008, 0x20701040, 0x40000030, 0x082020c8, 0x208808f8, 0x20200888, 0x2020f820, 0x8088f898, 0xb8808088, 0xa0882088, 0x88988880, 0x08a08880, 0xa8888820, 0x40402050, 0x00001010, 0x80887800, 0x8840f888, 0xc0102088, 0x8888a820, 0x70408888, 0xa8508840, 0x20208820, 0x00002020
	line6:	.word	0x50000000, 0x009098f0, 0x20a81040, 0x80000030, 0x88402088, 0x20888810, 0x20008888, 0x00400010, 0x88888880, 0x88808088, 0x90882088, 0x88888880, 0x88909880, 0xd8508820, 0x40802088, 0x00001008, 0x80888800, 0x78408088, 0xa0102088, 0x8888a820, 0x084078f0, 0xa8508840, 0x20407850, 0x00002020
	line7:	.word	0x50002000, 0x00681820, 0x00002020, 0x00200010, 0x70f87070, 0x20707010, 0x00007070, 0x20000000, 0x70f08878, 0x7080f8f0, 0x88707088, 0x708888f8, 0x70887880, 0x88207020, 0x70f82088, 0xf8007000, 0x78f07800, 0x08407878, 0x90907088, 0x7088a870, 0xf0400880, 0x50207830, 0x10f80888, 0x00004020
	line8:	.word	0x00000000, 0x00000000, 0x00000000, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xf0000000, 0x00600000, 0x00000000, 0x00000880, 0x00000000, 0x00007000, 0x00000000
	buffer:	.space	80
	enter:	.asciiz	"Please enter the filename: "
	filename:	.space	64
	print:	.space	60
	
.text
	#####################################################################
	#I was not able to get my code to work
	#I debugged all the segments individually and was able to read from the file and I was able to print to the file
	#but when I put the segments together it is not running correctly
	#I attempted to work out all the errors but I could not discover what was going wrong
	#######################################################################
	addi $t6, $zero, 10
	la $a0, enter
	addi $v0, $zero, 4
	syscall			#printing prompt message	

	addi $v0, $zero, 8
	la $a0, filename
	addi $a1, $zero, 64
	syscall			#asking for input

	nloop:			#removing newline character
	lb $t0, 0($a0)
	addi $a0, $a0, 1
	bne $t0, $zero, nloop
	addi $a0, $a0, -2
	sb $zero, 0($a0)

	addi $v0, $zero, 13		# system call for open file
  	la $a0, filename		# input file name
  	addi $a1, $zero, 0		# Open for reading (flags are 0: read, 1: write)
  	addi $a2, $zero, 0		# mode is ignored
  	syscall         		# open a file (file descriptor returned in $v0)
	add $s6, $zero, $v0		#saving file descriptor
	add $a0, $zero, $v0		#putting file descriptor in argument

main:
 	
	la $a1, buffer
	jal _readLine
	beq $v0, $zero, endp
	beq $v0, $t6, new
		
	la $a0, buffer
	jal _printBuffer
	
	j main

	endp:
	li   $v0, 16       # system call for close file
  	move $a0, $s6      # file descriptor to close
	syscall  

	addi $v0, $zero, 10
	syscall
	
	new:
	jal _newLine
	j main

_readLine:
	
	add $t0, $zero, $zero	#loop counter
	addi $t1, $zero, 80		#loop max
	addi $t2, $zero, 10 	#\n ascii code
	
	read:
	addi $t0, $t0, 1		#increment counter
 	addi $v0, $zero, 14		# system call for read from file
  	addi $a2, $zero, 1       	# hardcoded buffer length
  	syscall            		# write to file
	beq $v0, $zero, endLine	#branch if syscall returns 0
	lb $v0, 0($a1)
	beq $v0, $t2, endLine	#branch if \n
	addi $a1, $a1, 1		#increment buffer
	beq $t0, $t1, end		#end when 80 bytes are read
	j read

	endLine:
	sb $zero, 0($a1)		#filling the rest of the line with zeros
	addi $a1, $a1, 1		#increment buffer
	addi $t0, $t0, 1		#increment counter
	beq $t0, $t1, end		#end once all 80 bytes are filled
	j endLine
	end:
	jr $ra

_printBuffer:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, buffer
	la $a1, line1
	jal _printLine
	la $a0, buffer
	la $a1, line2
	jal _printLine
	la $a0, buffer
	la $a1, line3
	jal _printLine
	la $a0, buffer
	la $a1, line4
	jal _printLine
	la $a0, buffer
	la $a1, line5
	jal _printLine
	la $a0, buffer
	la $a1, line6
	jal _printLine
	la $a0, buffer
	la $a1, line7
	jal _printLine
	la $a0, buffer
	la $a1, line8
	jal _printLine
	jal _printSpace
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

_printLine:
	
	add $t0, $zero, $zero	#loop counter
	addi $t1, $zero, 60		#loop max
	add $s5, $zero, $a1		#storing line address
	la $a3, print		#print array
	
	build:
	lb $s0, 0($a0)		#loading character
	beq $s0, $zero, z
	addi $s0, $s0, -32		#getting printer code from line address
	add $a1, $a1, $s0
	lb $s0, 0($a1)
	z:
	add $a1, $zero, $s5
	addi $a0, $a0, 1		#incrementing buffer pointer
	lb $s1, 0($a0)		#loading next character
	srl $s1, $s1, 6		#getting top two bits
	beq $s0, $zero, z1
	addi $s1, $s1, -32		#getting printer code from line address
	add $a1, $a1, $s1
	lb $s1, 0($a1)
	z1:
	add $a1, $zero, $s5
	andi $s1, $s1, 3		#getting top two bits
	or $s3, $s1, $s2		#making first byte
	sb $s3, 0($a3)		#saving to the print array
	addi $a3, $a3, 1		#incrementing array pointer
	addi $t0, $t0, 1		#incrementing counter

	lb $s0, 0($a0)
	beq $s0, $zero, z2
	addi $s0, $s0, -32		#getting printer code from line address
	add $a1, $a1, $s0
	lb $s0, 0($a1)
	z2:
	add $a1, $zero, $s5
	addi $a0, $a0, 1
	andi $s0, $s0, 63
	lb $s1, 0($a0)
	beq $s0, $zero, z3
	addi $s1, $s1, -32		#getting printer code from line address
	add $a1, $a1, $s1
	lb $s1, 0($a1)
	z3:
	add $a1, $zero, $s5
	srl $s1, $s1, 4
	or $s3, $s1, $s2
	sb $s3, 0($a3)
	addi $a3, $a3, 1
	addi $t0, $t0, 1		#incrementing counter

	lb $s0, 0($a0)
	beq $s0, $zero, z4
	addi $s0, $s0, -32		#getting printer code from line address
	add $a1, $a1, $s0
	lb $s0, 0($a1)
	z4:
	add $a1, $zero, $s5
	addi $a0, $a0, 1
	andi $s0, $s0, 15
	lb $s1, 0($a0)
	beq $s0, $zero, z5
	addi $s1, $s1, -32		#getting printer code from line address
	add $a1, $a1, $s1
	lb $s1, 0($a1)
	z5:
	add $a1, $zero, $s5
	srl $s1, $s1, 2
	or $s3, $s1, $s2
	sb $s3, 0($a3)
	addi $a3, $a3, 1
	addi $t0, $t0, 1		#incrementing counter
	bne $t0, $t1, build
	
	add $t0, $zero, $zero	#loop counter
	addi $t1, $zero, 15		#loop max
	add $s5, $zero, $a1		#storing line address
	la $a3, print		#print array
	send:
	lw $t8, 0($a3)
	addi $a3, $a3, 4
	addi $t0, $t0, 1
	addi $t9, $zero, 1
	check:
	bne $t9, $zero, check
	bne $t0, $t1, send
	
	jr $ra
	
_printSpace:

	add $t0, $zero, $zero	#loop counter
	addi $t1, $zero, 75		#loop max

	white:
	addi $t9, $zero, 1
	check1:
	bne $t9, $zero, check1
	addi $t0, $t0, 1
	beq $t0, $t1, done
	j white
	done:
	jr $ra

_newLine:

	add $t0, $zero, $zero	#loop counter
	addi $t1, $zero, 120	#loop max

	white1:
	addi $t9, $zero, 1
	check2:
	bne $t9, $zero, check2
	addi $t0, $t0, 1
	beq $t0, $t1, done1
	j white1
	done1:
	jr $ra


	
