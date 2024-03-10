#binarysearch

.data
	prompt1: .asciiz "Enter number of elements N"
	prompt2: .asciiz "Enter N elements"
	
	promptFound: .asciiz "Element found"
	promptNotFound: .asciiz "Element not found"
	
	arr: .space 50
	maxsize: .word 100
	
.text
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	ori $t1, $0, 0 #set l to 0
	subi $t2, $t1, 1 #set t2 to r-1
	
	li $t9, 2
	
	L1:
	
	bge $t2, $t1, notFound 
	
	add $t3, $t1, $t2
	div $t3, $t9
	mflo $t3
	sll $t4, $t3, 2 
	lw $t5, arr($t4)
	
	beq $t5, $s1, found
	
	blt $s1, $t5, updateL
        bgt $s1, $t5, updateR

	found:
	
	li $v0, 4
	la $a0, promptFound
	syscall
	
	j end
	
	notFound:
	
	li $v0, 4
	la $a0, promptNotFound
	syscall
	
	j end
	
	updateL:
	addi $t1, $t3, 1
	j L1
	
	updateR:
	subi $t2, $t3, 1
	j L1
	
	end:
	li $v0, 10
	syscall