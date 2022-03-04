# ****** MIPS assembler program to calculate base^exponent recursively ******
# jsnyder17

.data
	string: .asciiz "Result: " 

.text
start:
	li $a0, 2		# base 
	li $a1, 5		# exponent 
	jal power		# calc base^exponent
	add $s0, $v0, $zero 	# store result in $s0
	j print			# jump to print routine to print result 
	
##########################################################################################################################
	
power:	addi $sp, $sp, -4	# allocate space on stack to store return address
	sw $ra, 0($sp)		# store return address on stack
	bne, $a1, 0, recur	# if (exponent != 0), recursive case
	addi $v0, $zero, 1	# else, load $v0 with 1 to return 
	addi $sp, $sp 4		# pop stack 
	jr $ra			# jump to return address 
	
recur:  
	addi $a1, $a1, -1	# a - 1
	jal power		# calc power(base, a - 1)
	mul $v0, $a0, $v0	# calc base * power(base, a - 1)
	lw $ra, 0($sp)		# load original return address from stack 
	addi $sp, $sp, 4	# pop stack 
	jr $ra			# jump to return address 

##########################################################################################################################

print:
	li $v0, 4		# service #4 to print string
	la $a0, string		# load address of string into $a0
	syscall			# syscall to print string 
	add $a0, $s0, $zero 	# load result into $a0
	li $v0, 1		# service #1 to print integer
	syscall			# syscall to print integer

##########################################################################################################################

exit:
