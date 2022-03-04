# ****** MIPS assembler program to calculate the factorials of integers 1-9 recursively ******
# jsnyder17

.data
	string: .asciiz "The factorials of integers 1-9 respectively are ... \n"
	newline_string: .asciiz "\n"
	array: .word 1 2 3 4 5 6 7 8 9

#######################################################################################################################

.text
start:
	la $s0, array	# $s0 contains base address of array 
	li $t0, 0	# i = 0
	
	addi $sp, $sp, -4	# allocate space to store original address of array on stack 
	sw $s0, 0($sp)		# store base address of array to stack 
	
fact_loop:
	beq $t0, 10, print	# while (i < 10)
	lw $a0, 0($s0)		# load next element in array into $a0 
	jal fact		# calc fact(n)
	sw $v0, 0($s0)		# store fact(n) in current index of array 
	addi $s0, $s0, 4	# increment to next array index  
	addi $t0, $t0, 1	# i++
	j fact_loop		
	
#######################################################################################################################	

fact:
	addi $sp, $sp, -8	# allocate space for two words on stack 
	sw $a0, 4($sp)		# store original value for n on stack
	sw $ra, 0($sp)		# store original return address on stack 
	
	bge $a0, 1, recur	# if (n < 1), base case
	addi $v0, $zero, 1	# return 1
	addi $sp, $sp, 8	# pop stack 
	jr $ra			# jump to return address 
	
recur:
	addi $a0, $a0, -1	# n - 1
	jal fact		# calc fact(n - 1)
	lw $a0, 4($sp)		# load original value of n from stack 
	mul $v0, $a0, $v0	# calc n * fact(n - 1) and store in $v0 to return 
	lw $ra, 0($sp)		# load original return address into $ra
	addi $sp, $sp, 8	# pop stack 
	jr $ra			# jump to return address 

#######################################################################################################################

print:
	lw $s0, 0($sp)		# load original address of array in $s0
	addi $sp, $sp, 4	# pop stack 
	
	li $v0, 4		# service #4 to print string 
	la $a0, string		# load address of string into $a0
	syscall			# system call to print string 
	
	li $t1, 0

print_loop:	
	beq $t1, 9, exit	# while (i < 10)
	li $v0, 1		# service #1 to print integer 
	lw $a0, 0($s0)		# load current index address of array into $a0
	syscall			# syscall to print integer 
	li $v0, 4		# service #1 to print string 
	la $a0, newline_string	# load newline_string into $a0 (this will print a new line to make room)
	syscall			# syscall to print string 
	addi $s0, $s0, 4	# increment to next index in array 	
	addi $t1, $t1, 1	# i++
	j print_loop
	
#######################################################################################################################
	
exit:
