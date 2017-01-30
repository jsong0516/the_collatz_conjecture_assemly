# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_iterative	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an ITERATIVE approach. This means that if the input is 1, your function should return 0.
#
# The initial value is stored in $a0, and you may assume that it is a positive number.
# 
# Make sure to follow all function call conventions.
collatz_iterative:
	# No replacement SP is needed since we can deal with $t0~$t3
	addi $t0, $0, 0 # total number 
	addi $t1, $0, 1 # base condition
	addi $t3, $0, 3 # multiplication constant
	
	if: # base case. n == 0
	beq $a0, $t1, end
	addi $t0, $t0, 1 # incrase number of repeat
	and $t2, $a0, $t1 # t2 set if a0 is odd number
	beq $t2, $t1, else # jump to else if odd condition
	
	elseif: # if even number
	srl $a0, $a0, 1 # divide by two
	j if
	
	else: # odd condition
	mult $a0, $t3
	mflo $a0 # getting only low number
	addi $a0, $a0, 1 
	j if
	end:
	
	add $v0, $zero, $t0
	jr $ra


