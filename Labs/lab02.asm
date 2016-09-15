.data
	numPrompt: .asciiz "Enter a number between 0 and 9: "
	mlow: .asciiz "Your guess is too low.\n"
	mhigh: .asciiz "Your guess is too high.\n"
	mlose: .asciiz "You lose. The number was "
	mperiod: .asciiz ".\n"
	mwin: .asciiz "Congratulations! You Win!\n"
	
.text
	addi $t1, $zero, 3	#max counter
	addi $t4, $zero, 1	#true/false tester
	addi $v0, $zero, 30	#getting system time
	syscall			
	add $a1, $zero $a0	#moving lower 32 bits to $a1 for seed
	addi $a0, $zero, 0	#setting generator ID
	addi $v0, $zero, 40	#adding 40 for generator creation syscall
	syscall
	addi $v0, $zero, 42	#adding 42 for random number syscall
	add $a1, $zero, 10	#adding upper bound (exclusive)
	syscall
	add $s0, $zero, $a0	#storing random number in $s0
guess:
	addi $v0, $zero, 4	#syscall for string print
	la $a0, numPrompt	#loadin address
	syscall
	addi $v0, $zero, 5	#syscall to prompt integer
	syscall
	add $s1, $zero, $v0	#moving integer to $s1
	addi $t0, $t0, 1	#counter	
test:
	beq $s0, $s1, win	#testing there guess
	slt $t3, $s1, $s0	#testing if less
	beq $t3, $t4, low	#deciding where to jump
	j high	
low:
	addi $v0, $zero, 4	#displaying too low message
	la $a0, mlow		
	syscall
	beq $t0, $t1, lose	#testing how many guesses were taken
	j guess
high:
	addi $v0, $zero, 4	#displaying too high message
	la $a0, mhigh
	syscall	
	beq $t0, $t1, lose	#testing how many guesses
	j guess
win:
	addi $v0, $zero, 4	#displaying win message
	la $a0, mwin
	syscall
	j end			#bypassing lose message
lose:	
	addi $v0, $zero, 4	#displaying lose message
	la $a0, mlose
	syscall		
	addi $v0, $zero, 1
	add $a0, $zero, $s0
	syscall
	addi $v0, $zero, 4
	la $a0, mperiod
	syscall
end:	
	addi $v0, $zero, 10	#ending program
	syscall
