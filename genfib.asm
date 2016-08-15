###################################################
### Jameson Treu
###################################################
### Main Program
### n = $a0
### F() = $v0
### a = $t1
### b = $t2
### p = $t3
### q = $t4
###################################################
	.text	
	### $t1
	la $a0,prompt
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	### $t2
	la $a0,prompt1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	
	### $t3
	la $a0,prompt2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t3,$v0
	
	### $t4 
	la $a0,prompt3
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t4,$v0
	
	## non-negative input - $a0
	la $a0,prompt4
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t5,$v0
	move $a0, $v0
	
	jal fib
	move $t6, $v0
	
	la $a0,result1
	li $v0,4
	syscall
	
	move $a0,$t5
	li $v0,1 
	syscall 
	
	la $a0,result2
	li $v0,4
	syscall
	
	
	move $a0,$t6
	li $v0,1
	syscall 
	
	li $v0,10
	syscall
####################################################
### Fibonacci Subroutine
### Recursive implementation of the Fibonacci function
### Values to put on stack
### n = $a0
### intermediate value fib(n-1)
### $ra
####################################################
####################################################
### F(0) = 0 and F(1) = 1
####################################################
fib: 
	bgt $a0,1,gt1
	li $t7,0
	beq $a0, $t7, else
	li $t8,1
	beq $a0,$t8, else2
else:	
	move $v0, $t1
	j endif
else2:
	move $v0, $t2
	j endif
endif:
	jr $ra
gt1: 
	sub $sp,$sp,12
	sw $a0,0($sp)
	sw $ra,8($sp)
	sub $a0,$a0,1
####################################################
### Compute F(n-1)
####################################################
	jal fib
	
	move $s0,$v0
	mul $s0, $s0, $t3
	lw $a0,0($sp)
	lw $ra,8($sp)
	add $sp,$sp,12
	
	sub $sp,$sp,12
	sw $a0,0($sp)
	sw $s0,4($sp)
	sw $ra,8($sp)
	
	sub $a0,$a0,2
###################################################
### Compute F(n-2)
###################################################
	jal fib
	
	mul $v0,$v0,$t4
	lw $s0,4($sp)
	lw $ra,8($sp)
	sub $v0,$s0,$v0
	add $sp,$sp,12
	
	jr $ra
	
	.data
prompt:	.asciiz "Input integer a: "
prompt1: .asciiz "Input integer b: "
prompt2: .asciiz "Input integer p: "
prompt3: .asciiz "Input integer q: "
prompt4: .asciiz "Input integer n: "
result1: .asciiz "w("
result2: .asciiz ") = "
endl:.ascii "\n"
