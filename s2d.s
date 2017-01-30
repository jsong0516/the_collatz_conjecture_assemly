##### sparse2dense function code #####
.text
# sparse2dense will have 2 arguments: $a0 = address of sparse matrix data, $a1 = address of dense matrix, $a2 = matrix width
# Recall that sparse matrix representation uses the following format:
# Row r<y> {int row#, Elem *node, Row *nextrow}
# Elem e<y><x> {int col#, int value, Elem *nextelem}
sparse2dense:
	beq $a0, $0, clean # if ROW IS NULL return
	sll $t9, $a2, 2 # matrix width multiplied by 4. Size of each entry of element in row 
	addu $t8, $0, $0 # t8 is a counter for row
	
	while:  beq $a0, $0, end # end if no more sparse
		
		add $t0, $0, $0 # Elem counter
		lw $t1, 0($a0) # t1 has row number
		lw $t2, 4($a0) # Elem list address
		lw $t3, 8($a0) # Next Row address
		
		beq $t8, $t1, while_elem # If row number match with count, it need to start write
		#else it should increase $t8 and $a1
		addu $a1, $a1, $t9 # SKIP WHOLE ROW
		addiu $t8, $t8, 1 # incrase counter
		j while	
			
		while_elem:
			beq $t2, $0, end_elem #t2 is Elem List address
			
			# if co# matches with count
			lw $t5, 0($t2)  # t5 has column number 
			bne $t5, $t0, end_color # t0 has Elem Counter and if column number is not matching
			
			lw $t5, 4($t2) # get color value
			lw $t2, 8($t2) # advance elem
			sw $t5, 0($a1) # Set color value to current location
			addiu $a1, $a1, 4 # advance to next index of the array matrix
			
			end_color:
			addiu $t0, $t0, 1
			
			j while_elem
		end_elem:
		addu $a0, $0, $t3 # Advance head to next row
		bne $a0, $0, while # Not equal to null
	end:
	# add null to the end of matrix 
	sw $0, 0($a1)
	
	clean:
	jr $ra
