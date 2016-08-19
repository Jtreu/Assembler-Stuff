###################################################
### Jameson Treu
### 700618652
### jst86520
###################################################
### Main Program
### $a0 = 9
### $v0 = F(9)
###################################################
	.text
	
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	move $a0,$t0
	jal perrin
	move $a0,$v0
	li $v0,1
	syscall
	
	la $a0,endl
	li $v0,4
	syscall
	
	li $v0,10
	syscall
####################################################
### Perrin Subroutine
### Recursive implementation of the Perrin function
### Values to put on stack
### n = $a0
### intermediate value P(n-1)
### $ra
####################################################
####################################################
###	F(0) = 0 and F(1) = 1
####################################################
perrin:	bne $a0,0,ne0
	li $v0, 3
	jr $ra

ne0:	bne $a0,1,ne1
	li $v0, 0
	jr $ra
	
ne1:	bne $a0,2,ne2
	li $v0, 2
	jr $ra

ne2:	sub $sp, $sp, 12
	sw $a0, 0($sp)
	sw $ra, 8($sp) 
	
	sub $a0, $a0, 2
####################################################
###	Compute P(n-2)
####################################################
	jal perrin
	
	move $s0,$v0
	lw $a0,0($sp)
	lw $ra,8($sp)
	add $sp,$sp,12
	
	sub $sp,$sp,12
	sw $a0,0($sp)
	sw $s0,4($sp)
	sw $ra,8($sp)
	
	sub $a0,$a0,3
###################################################
###	Compute P(n-3)
###################################################
	jal perrin
	
	lw $s0,4($sp)
	lw $ra,8($sp)
	add $v0,$v0,$s0
	add $sp,$sp,12
	
	jr $ra
	
	.data
endl:	.asciiz "\n"
prompt: .asciiz "Please enter an integer: "