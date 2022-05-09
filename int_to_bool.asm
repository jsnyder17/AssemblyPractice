;##################################################
; A very useful program to convert an integer to a
; boolean value. 
;
; Joshua Snyder
;
;##################################################

.globl _start

.data
	data: .word 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9	; These values won't be integers for long!
	
.text
_start:
	la $t0, data
	lw $t1, 0($t0)
	li $t2, 10
	
Loop:
	beq $t1, $t2, Exit 
	add $a0, $t1, $zero 
	jal IntToBool
	sw $v0, 0($t0)
	addi $t1, $t1, 1
	addi $t0, $t0, 4
	j Loop
	
IntToBool:
	bne $a0, 1, False
	add $v0, $a0, $v0
	jr $ra
	
False:
	add $v0, $zero, $zero
	jr $ra

Exit: