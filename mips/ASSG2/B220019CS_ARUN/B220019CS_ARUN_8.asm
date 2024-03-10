.data
    newline:    .asciiz "\n"
    prompt1:    .asciiz "Enter the number of elements: "
    prompt2:    .asciiz "Enter element: "
    prompt3:    .asciiz "Array elements: "
    not_found:  .asciiz "Element not found.\n"
    found:      .asciiz "Element found at index "

    max_size:   .word 100

    array:      .space 400  #400/4 = 100 elements max size

.text

main:
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0 
    move $s2, $v0 

    la $v0, 4
    la $a0, prompt2
    syscall

    li $t0, 0

input_loop:

    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall
    sw $v0, array($t0) 

    addi $t0, $t0, 4

    addi $s0, $s0, -1
    bnez $s0, input_loop

    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0  

    li $t0, 0        

search_loop:
    lw $t2, array($t0)

    beq $t2, $s1, element_found

    addi $t0, $t0, 4

    bge $t0, $s2, element_not_found

    j search_loop

element_found:
    li $v0, 4
    la $a0, found
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    j exit_program

element_not_found:
    li $v0, 4
    la $a0, not_found
    syscall

exit_program:
    li $v0, 10
    syscall
