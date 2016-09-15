.text

state0:

	addi $s0, $zero, 10		#value of plus
	addi $s1, $zero, 11		#value of minus
	addi $s2, $zero, 12		#value of multiplication
	addi $s3, $zero, 13		#value of division
	addi $s4, $zero, 14		#value of equals
	addi $s5, $zero, 15		#value of clear
	addi $s6, $zero, 9		#value of nine for the *10 loop
	add $t0, $zero, $zero	#operator
	add $t1, $zero, $zero	#operand 1
	add $t2, $zero, $zero	#operand 2
	add $t3, $zero, $zero	#counter
	add $t4, $zero, $zero	#intermediate for *10 loop
	add $t5, $zero, $zero	#result
	add $t8, $zero, $zero	#display segment
	add $t9, $zero, $zero	#calculator input
statec1:
	add $t4, $zero, $zero	#intermediate reset for return to state1
state1:

	beq $t9, $zero, state1	#testing when button is pressed
	andi $t9, $t9, 15		#extracting input
	
	beq $t9, $s0, op		#jumping to op to set operation
	beq $t9, $s1, op		
	beq $t9, $s2, op
	beq $t9, $s3, op
	beq $t9, $s4, _equals	#jumping to _equals if equals is pressed
	beq $t9, $s5, state0	#reseting when clear is pressed

	add $t3, $zero, $zero	#*10 loop
	loop1:
	add $t4, $t1, $t4
	addi $t3, $t3, 1
	bne $t3, $s6, loop1
	add $t1, $t4, $t9		#storing values
	add $t4, $zero, $t1

	add $t8, $zero, $t1		#displaying input
	add $t9, $zero, $zero	#clearing input buffer
	add $t5, $zero, $zero	#clearing result
	j state1

state2:
	beq $t9, $zero, state2	#testing when button is pressed
	andi $t9, $t9, 15		#extracting input

	beq $t9, $s0, op		#jumping to op to set operation
	beq $t9, $s1, op
	beq $t9, $s2, op
	beq $t9, $s3, op
	beq $t9, $s4, _equals	#jumping to _equals if equals is pressed
	beq $t9, $s5, state0	#reset call upon clear press

	add $t3, $zero, $zero	#*10 loop
	add $t4, $zero, $t2
	loop2:
	add $t4, $t2, $t4
	addi $t3, $t3, 1
	bne $t3, $s6, loop2
	add $t2, $t4, $t9		#storing input
	add $t4, $zero, $t2		#copying input

	add $t8, $zero, $t2		#displyaing
	add $t9, $zero, $zero	#reseting input 
state3:
	beq $t9, $zero, state3	#testing when button is pressed
	andi $t9, $t9, 15		#extracting input

	beq $t9, $s0, answer	#branching to compute previous choice
	beq $t9, $s1, answer
	beq $t9, $s2, answer
	beq $t9, $s3, answer
	beq $t9, $s4, answer1
	beq $t9, $s5, state0

	add $t3, $zero, $zero	#*10 loop
	add $t4, $zero, $t2
	loop3:
	add $t4, $t2, $t4
	addi $t3, $t3, 1
	bne $t3, $s6, loop3
	add $t2, $t4, $t9		#storing input
	add $t4, $zero, $t2		#copying input

	add $t8, $zero, $t2	
	add $t9, $zero, $zero
	j state3
state4:
	beq $t9, $zero, state4	#testing when button is pressed
	andi $t9, $t9, 15		#extracting input

	beq $t9, $s0, op		#branching depending on input
	beq $t9, $s1, op
	beq $t9, $s2, op
	beq $t9, $s3, op
	beq $t9, $s4, _equals	
	beq $t9, $s5, state0

	add $t1, $zero, $t9

	add $t8, $zero, $t1	
	add $t9, $zero, $zero
	j statec1

_equals:
	add $t5, $zero, $t1		#setting result to t1
	add $t8, $zero, $t5		#displaying
	add $t9, $zero, $zero
	j state4
op:
	bne $t2, $zero, state3	#going to state 3 if a computation is needed
	add $t0, $zero, $t9		#storing selected operator
	add $t9, $zero, $zero
	j state2
answer:
	beq $t0, $s0, _add		#deciding what operation to branch to
	beq $t0, $s1, _sub		#this is the operation after another operator was pressed
	beq $t0, $s2, _mult		#therefore after the previous computation is coputed I need to store the new
	beq $t0, $s3, _div		#operator for the next computation
answer1:
	beq $t0, $s0, _add1		#deciding what operation to branch to
	beq $t0, $s1, _sub1		#these are operations after ='s is pressed
	beq $t0, $s2, _mult1	#therefore no new operation needs stored
	beq $t0, $s3, _div1
_add:
	add $t5, $t1, $t2		#result is t1+t2
	add $t8, $zero, $t5		#setting new values
	add $t1, $zero, $t5
	add $t0, $zero, $t9		#storing new operation
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state2
_add1:
	add $t5, $t1, $t2		#result is t1+t2
	add $t8, $zero, $t5		#setting new values
	add $t1, $zero, $t5
	add $t0, $zero, $zero	
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state4
_sub:
	sub $t5, $t1, $t2		#result is t1-t2
	add $t8, $zero, $t5		#setting new values
	add $t1, $zero, $t5
	add $t0, $zero, $t9		#storing new operator
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state2	
_sub1:
	sub $t5, $t1, $t2		#result is t1-t2
	add $t8, $zero, $t5		#setting new values
	add $t1, $zero, $t5
	add $t0, $zero, $zero
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state4
_mult:
	add $t5, $zero, $zero
	add $t3, $zero, $zero
	beq $t1, $zero, zeroc	#testing either integer for 0
	beq $t2, $zero, zeroc

	loopm:			#multiplying
	add $t5, $t5, $t1
	addi $t3, $t3, 1
	bne $t3, $t2, loopm

	add $t8, $zero, $t5		#storing new values
	add $t1, $zero, $t5
	add $t0, $zero, $t9
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state2
_mult1:
	add $t5, $zero, $zero
	add $t3, $zero, $zero
	beq $t1, $zero, zeroc1	#testing either integer for 0
	beq $t2, $zero, zeroc1

	loopm1:			#multiplying
	add $t5, $t5, $t1
	addi $t3, $t3, 1
	bne $t3, $t2, loopm1

	add $t8, $zero, $t5		#storing new values
	add $t1, $zero, $t5
	add $t0, $zero, $zero
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state4
_div:
	add $t5, $zero, $zero
	slt $t3, $t1, $zero
	bne $t3, $zero, _divn	#testing for negative numerator
	add $t3, $zero, $zero
	beq $t1, $zero, zeroc	#testing for zero

	loopd:			#dividing
	sub $t1, $t1, $t2
	addi $t5, $t5, 1
	slt $t3, $t1, $t2
	beq $t3, $zero, loopd

	add $t8, $zero, $t5		#storing new values
	add $t1, $zero, $t5
	add $t0, $zero, $t9
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state2
_div1:
	add $t5, $zero, $zero	
	slt $t3, $t1, $zero
	bne $t3, $zero, _divn1	#testing for negative numerator
	add $t3, $zero, $zero
	beq $t1, $zero, zeroc	#testing for zero

	loopd1:			#dividing
	sub $t1, $t1, $t2
	addi $t5, $t5, 1
	slt $t3, $t1, $t2
	beq $t3, $zero, loopd1

	add $t8, $zero, $t5		#storing new values
	add $t1, $zero, $t5
	add $t0, $zero, $zero
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state4	
zeroc:
	add $t0, $zero, $t9		#this handles for when a zero is given to the mult or div functions
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t5, $zero, $zero
	add $t8, $zero, $zero
	add $t9, $zero, $zero
	j state2
zeroc1:
	add $t0, $zero, $zero	#this handles when a zero is given to the mult or div function and no new operator
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t5, $zero, $zero
	add $t8, $zero, $zero
	add $t9, $zero, $zero
	j state4
_divn:
	add $t3, $zero, $zero
	nor $t1, $t1, $zero		#inverting bit so original algorithm can be used
	addi $t1, $t1, 1		#adding one for two's complement
	loopn:			#dividing
	sub $t1, $t1, $t2
	addi $t5, $t5, 1
	slt $t3, $t1, $t2
	bne $t3, $zero, loopn
	nor $t5, $t5, $zero		#inverting bit so original algorithm can be used
	addi $t5, $t5, 1		#adding one for two's complement
	add $t8, $zero, $t5
	add $t1, $zero, $t5
	add $t0, $zero, $t9
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state2
_divn1:
	add $t3, $zero, $zero
	nor $t1, $t1, $zero		#inverting bit so original algorithm can be used
	addi $t1, $t1, 1		#adding one for two's complement
	loopn1:			#dividing
	sub $t1, $t1, $t2
	addi $t5, $t5, 1
	slt $t3, $t1, $t2
	beq $t3, $zero, loopn1
	nor $t5, $t5, $zero		#inverting bit so original algorithm can be used
	addi $t5, $t5, 1		#adding one for two's complement
	add $t8, $zero, $t5
	add $t1, $zero, $t5
	add $t0, $zero, $zero
	add $t2, $zero, $zero
	add $t9, $zero, $zero
	j state4	