# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_recursive	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an RECURSIVE approach. This means that if the input is 1, your function should return 0.
#
# The current value is stored in $a0, and you may assume that it is a positive number.
#
# Make sure to follow all function call conventions.

collatz_recursive:
	# Beginning
	addi $sp, $sp, -4 # return address
	sw $ra, 0($sp)
	
	addi $v0, $0, 0  # Initialization
	addi $t1, $0, 3   # multiplication constant
	add $t0, $0, 1   # Base condition

	# Base condition
	beq $a0, $t0, endAndClear
	andi $t0, $a0, 1 # Set t0 if a0 is odd
	bne $t0, $0,  odd# go to odd if $t0 is not 0. t0 is 
	
	# Recursive call 1 - even
	srl $a0, $a0, 1 # Divide 2
	jal collatz_recursive # I don't need any more resistor once recursive function is called.
	addi $v0, $v0, 1
	j endAndClear
	
	odd:
	# Recursive call 2 - odd
	mult $a0, $t1 # multiplication
	mflo $a0      # Get data
	addi $a0, $a0, 1 # add one
	jal collatz_recursive # I don't need any more resistor once recursive function is called.
	addi $v0, $v0, 1
	
	endAndClear:
	# Ending
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra		
