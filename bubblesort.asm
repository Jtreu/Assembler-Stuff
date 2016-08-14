### Input a number of integers (n) from the keyboard
### and sort them in ascending order
### bubblesort.asm
### Jameson Treu

	.text

### Input size of integer array n
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

### Loop to input n integers and store them in address of $s0
### $t2 is address of current integer in array
### $t3 is the number of integers left to input

	move $t2,$s0
	move $t3,$t0
loop:
	li $v0,4
	la $a0,prompt2
	syscall
	li $v0,5
	syscall
	sw $v0,0($t2)
	addi $t2,$t2,4
	addi $t3,$t3,-1
	bnez $t3,loop

### Prepare to call bubble Sort
### $a0 is the address of the integer array
### $a1 is number of numbers in integer array

	move $a0,$s0
	move $a1,$t0
	jal bubble

### Print Sorted Integer Array
### $t1 is address of array element i
### $t2 is number of elements left to print

	li $v0,4
	la $a0,prompt4
	syscall
	li $v0,4
	la $a0,endl
	syscall
	move $t1,$s0
	move $t2,$t0
loop2:
	beqz $t2,finish
	li $v0,1
	lw $a0,0($t1)
	syscall
	li $v0,4
	la $a0,endl
	syscall
	addi $t1,$t1,4
	addi $t2,$t2,-1
	j loop2

### Exit

finish:
	li $v0,10
	syscall

### Bubble Sort Algorithm
### void bubbleSort(int[] arr) { 
### 	int i, j, newValue; 
### 	for (i = 1; i < arr.length; i++) { 
### 		newValue = arr[i]; 
### 		j = i; 
### 		while (j > 0 && arr[j - 1] > newValue) { 
### 			arr[j] = arr[j - 1]; 
### 			j--; 
### 		} 
### 		arr[j] = newValue; 
### 	} 
### }

### $t1 is address of array element i
### $t2 is the value of i
### $t3 is address of array element j
### $t4 is the value of j
### $t5 is newValue
### $t6 is address of array element j-1
### $t7 is contents of array element j-1

bubble:
	move $s0,$a0
	move $t0,$a1
	li $t1,1 ### Set swapped to true and j to 0
	li $t2,0

while: 

	beqz $t1,done 
	li $t1,0
	addi $t2,$t2,1
	li $t5,0
	move $t3,$t0
	sub $t3, $t3,$t2
	move $t6,$s0 
	addi $t9,$t6,4
	addi $t8,$t5,1

for: 
	bge $t5,$t3,endfor
	lw $t7,0($t6)
	lw $s1,0($t9)
	ble $t7,$t1,next
	move $t4,$t7
	sw $s1,0($t6)
	sw $t4,0($t9)
	li $t1,1

next:
 
	addi $t5,$t5,1
	addi $t8,$t8,1
	addi $t6,$t6,4
	addi $t9,$t9,4
	j for

endfor:

### Print Partially Sorted Integer Array
### $t8 is the address of next integer array element to print
### $t9 is the number of elements left to print

	li $v0,4
	la $a0,prompt3
	syscall

	li $v0,4
	la $a0,endl
	syscall

	move $s2,$s0
	move $s3,$t0
loop3: 
	beqz $s3,endprint
	li $v0,1
	lw $a0,0($s2)
	syscall

	li $v0,4
	la $a0,endl
	syscall

	addi $s2,$s2,4
	addi $s3,$s3,-1
	j loop3
endprint:

	j while
  
	done: jr $ra
	.data
prompt:
	.asciiz "Input size of integer array: "
prompt2:
	.asciiz "Input integer: "
prompt3:
	.asciiz "Partially Sorted Integer Array: "
prompt4:
	.asciiz "Bubble Sorted Integer Array: "
endl:	.asciiz "\n"

### $t0 # of #'s in array
### $t1 swapped
### $t2 j
### $t3 n-j
### $t4 tmp
### $t5
### $t6 address of arr[i]
### $t7 contents of arr[i]
### $t8 i+1
### $t9 address of arr [i+1]
### $s1 contents of arr[i+1]
