### Store the integers in an array X
### Find the maximum integer input out of all the inputs
### Output that maximum value
### maxsub.asm
### Jameson Treu	
	.text
###	$t0 - Number of Numbers
###	$t1 - Current address in X 
###	$t2 - Integer Input
	li $t0, 0
	la $t1, X
loop:	la $a0, prompt
	li $v0, 4
	syscall
	
###	Input Integer
	li $v0, 5
	syscall
	move $t2, $v0
	
### 	Check for 0 Input
###	If 0, prepare to call subroutine
###	If not 0, store integer in X and continue

	beqz $t2, next
	sw $t2, 0($t1)
	addi $t0, $t0, 1	### add 1 to the number count
	addi $t1, $t1, 4	### increment t1 (which is allocated to the address of x)
	b loop
	
###	Call subroutine sum
###	Pass adress of X in $a0 and number of elements in X in $a1
###	Upon return, $v0 contains the sum
next:	la $a0, X	### $a0 = address of X
	move $a1, $t0	### $a1 = number count
	jal max		### what does this do?
	move $t1, $v0	### t1 = max (which is $v0)
	
###	Output Message and Max number
	la $a0, prompt2
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
###	Exit
	li $v0, 10
	syscall
	
###	$t0 - Current biggest number
### 	$t1 - Current address in X
###	$t2 - Number of integers left to add
###	$t3 - Current integer
max:	
	li $t0, 0
	move $t1, $a0
	move $t2, $a1
	
loop2:	beqz $t2, end
	lw $t3, 0($t1)
	subi, $t2, $t2, 1
	addi $t1, $t1, 4
	bgt $t3, $t0, storeMaxNum
	j loop2
	
storeMaxNum:
	move $t0, $t3
	j loop2

end:	
	move $v0, $t0
	jr $ra
	
	.data
X:	.space 400
prompt:
	.asciiz "Input non-negative integer, terminated by 0: "
prompt2:
	.asciiz "The maximum of the integers input is: "
endl:	.asciiz "\n"
