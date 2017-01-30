##### Variables #####
.data
# Header for dense matrix
head:		.asciiz	"  -----0----------1----------2----------3----------4----------5----------6----------7----------8----------9-----\n"

##### print_dense function code #####
.text
# print_dense will have 3 arguments: $a0 = address of dense matrix, $a1 = matrix width, $a2 = matrix height
print_dense:
	addiu $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	
	
	## HEAD
	
	
	addiu $s1, $0, 0 # counter for height
	addu $s2, $0, $a0 # address
	addu $s3, $0, $a1 # WIDTH 
	addu $s4, $0, $a2 # HEIGHT
	
	while_print_height:
		bge $s1, $s4, end_while_print_height # if count < HEIGHT
		
		addiu $s0, $0, 0 # counter for width
		# print ROW NUMBER
		addu $a0, $s1, $0 
		jal print_int
	
		# print space
		jal print_space
	
		# print matrix
		while2:
			bge $s0, $s3, end2 # if count_width < width 
			lw $a0, 0($s2)
			# print_intx:
			jal print_intx
			
			# print space
			jal print_space
			addiu $s2, $s2, 4
			addiu $s0, $s0, 1
			j while2
		end2:	
		
		# print newline
		jal print_newline
		addiu $s1, $s1, 1
		j while_print_height
	end_while_print_height:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addiu $sp, $sp, 24
	jr $ra
