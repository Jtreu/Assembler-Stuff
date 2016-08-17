### Jameson Treu
### MeanVariance Program

	.text
	
### Input size of float array n
### Store size in $t0

	li $v0,4
	la $a0,prompt
	syscall
	li $v0,5
	syscall
	move $t0,$v0	
	
### Allocates a block of memory of size $t1 = 4xn
### Puts the address of the block in $s0

	add $t1,$t0,$t0
	add $t1,$t1,$t1
	li $v0,9
	move $a0,$t1
	syscall
	move $s0,$v0
	
### Loop to input n floats and store them in address of $s0
### $t2 is address of current float in array
### $t3 is the number of integers left to input

	move $t2,$s0
	move $t3,$t0
loop:
	li $v0,4
	la $a0,prompt2
	syscall
	li $v0,6
	syscall
	s.s $f0,0($t2)
	addi $t2,$t2,4
	addi $t3,$t3,-1
	bnez $t3,loop
	
### Print the array of floats
	li $v0, 4
	la $a0, endl
	syscall
	li $v0, 4
	la $a0, display
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	move $s2, $s0
	move $s3, $t0
	
loop2: 
	beqz $s3,callFunctions
	li $v0,2
	l.s $f12,0($s2)
	syscall

	li $v0,4
	la $a0,whiteSpace
	syscall

	addi $s2,$s2,4
	addi $s3,$s3,-1
	j loop2
callFunctions:
	move $a0, $t0
	move $a1, $s0
	jal mean
	
	mov.s $f0, $f12
	
	li $v0, 4
	la $a0, endl
	syscall
	
	li $v0, 4
	la $a0, displayMean
	syscall
	
	li $v0, 2	
	mov.s $f12, $f0
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall

	move $a0, $t0
	move $a1, $s0

	jal variance
	
	li $v0, 4
	la $a0, displayVariance
	syscall
	
	li $v0, 2
	mov.s $f12, $f12
	syscall
	
	li $v0, 10
	syscall
	

### $t1 is the size of the array used as an decrement counter
### $t2 is the size of the array
### $t3 is the address of the array element 
### $f1 is current value from array
### $f2 is the running total
### $f3 is the floating point representation of the mean
### $f4 is the mean


mean:
	move $t1, $a0
	move $t2, $a0
	move $t3, $a1
	
loop3: 
	beqz $t1, divide
	l.s $f1, 0($t3)
	add.s $f2, $f2, $f1

	addi $t3, $t3, 4
	addi, $t1, $t1, -1
	j loop3

divide:
	mtc1 $t2, $f3
	cvt.s.w $f3, $f3
	div.s $f4, $f2, $f3
	mov.s $f12, $f4
	jr $ra
	
### $t1 is the size of the array used as an decrement counter
### $t2 is the size of the array
### $t3 is is the address of the array element
### $f1 is current value from array
### $f2 is the running total
### $f3 is the floating point representation of the mean
### $f5 is the floating point representation of n
### $f6 is the variance
### $f7 is the temporary sum value

variance: 
	move $t1, $a0
	move $t2, $a0
	move $t3, $a1
	mov.s $f3, $f0
	
loop4: 
	beqz $t1, divideVariance
	l.s $f1, 0($t3)
	sub.s $f7, $f1, $f3
	mul.s $f7, $f7, $f7
	add.s $f2, $f2, $f7

	addi $t3, $t3, 4
	subi, $t1, $t1, 1
	j loop4

divideVariance:
	mtc1 $t2, $f5
	cvt.s.w $f5, $f5
	div.s $f6, $f2, $f5
	sub.s $f6, $f6, $f3
	mov.s $f12, $f6
	jr $ra
	
	.data
prompt:
	.asciiz "Input size of float array: "
prompt2:
	.asciiz "Input float: "
display:
	.asciiz "The list of numbers: "
whiteSpace:
	.asciiz " "
displayMean:
	.asciiz "Mean: "
displayVariance:
	.asciiz "Variance "

endl:   .asciiz "\n"

