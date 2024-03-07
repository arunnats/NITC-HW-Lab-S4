.data
    newline: .asciiz "\n"
    input_prompt: .asciiz "Enter N to find the Nth number: "
    output_prompt: .asciiz "Nth Fibonnaci Number is: "
.text

main:
    li $v0, 4
    la $a0, input_prompt
    syscall
    li $v0, 5
    syscall
    move $s0, $v0  

    li $t0, 0
    li $t1, 1
    
    beq $s0, 0, outZero
    beq $s0, 1, outOne
    
    li $t2, 2
    
    loop:
    add $s1, $t1, $t0
    
    addi $t2, $t2, 1
    beq $t2, $s0, exit
    j loop
    
    exit:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, output_prompt
    syscall
    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 10
    syscall
    
    outZero:
    
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, output_prompt
    syscall
    li $v0, 1
    li $a0, 0
    syscall

    li $v0, 10
    syscall
    
    outOne:
    
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, output_prompt
    syscall
    li $v0, 1
    li $a0, 1
    syscall

    li $v0, 10
    syscall
    
    