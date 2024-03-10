.data
	array: .space 100
	array_size: .word 0
	size: .asciiz "Enter size of array: "
	prompt: .asciiz "Enter an element: "
	key: .asciiz "Enter key to search: "
	yes: .asciiz "Key found at position "
	no: .asciiz "Key not found in array"
	
.text

main:
	li $v0, 4
	la $a0, size
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	sw $t0, array_size
	
	li $t1, 0
	la $t3, array
	li $t2, 1 #position
	
input:
	beq $t1, $t0, search
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	sw $v0, ($t3)
	
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	
	j input
	
search:
	li $v0, 4
	la $a0, key
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $t4, 0 #beg
	subi $t5, $t0, 1
	mul $t5, $t5,  4 #end
	
	loop:
    bgt $t4, $t5, notfound
    add $t6, $t4, $t5
    div $t6, $t6, 2
    mflo $t7

    # Calculate the correct address with the proper offset (multiply by 4)
    la $t8, array
    add $t8, $t8, $t7
    sll $t8, $t8, 2  # Multiply by 4 to get the correct word offset
    lw $t8, 0($t8)

    beq $t8, $s1, found

    blt $t8, $s1, updatebeg
    bgt $t8, $s1, updateend

updateend:
    addi $t5, $t7, -1
    addi $t1, $t1, 1
    j loop

updatebeg:
    addi $t4, $t7, 1
    addi $t1, $t1, 1
    j loop
		
found:
	li $v0, 4
	la $a0, yes
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	j exit
	
notfound:
	li $v0, 4
	la $a0, no
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall