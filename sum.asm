### Sum integers entered by the user
### sum.asm
### Jameson Treu
 
	.text
	li $t0,0
next:
###	Prompt to Input an Integer
	la $a0,prompt
	li $v0,4
	syscall
	
###	Input n
	li $v0,5
	syscall
	sw $v0,integer
	
###	$t0 is running total
###	$t1 is the user's integer
	lw $t1,integer
	beqz $t1,end
	add $t0,$t0,$t1
	b next
	
###	Output Message and Sum
end:	la $a0,prompt2
	li $v0,4
	syscall
	
	move $a0,$t0
	li $v0,1
	syscall
	
	la $a0,endl
	li $v0,4
	syscall
	
###	Exit
	li $v0,10
	syscall
	
	
	.data
integer: .word	0
prompt:
	.asciiz "Input any integer, input 0 to terminate program: "
prompt2:
	.asciiz "The sum of your integers is: "
endl:	.asciiz "\n"
