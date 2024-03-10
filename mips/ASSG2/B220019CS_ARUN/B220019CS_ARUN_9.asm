.data
    newline:        .asciiz "\n"
    input_prompt:   .asciiz "Enter N to find the Nth number: "
    output_prompt:  .asciiz "Nth Fibonacci Number is: "
.text

main:
    li $v0, 4
    la $a0, input_prompt
    syscall
    
    #user input
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 contains N

    li $t0, 0      #first Fibonacci number
    li $t1, 1      #second Fibonacci number
    
    #handle edge cases (N = 0 or N = 1)
    beq $s0, 0, outZero
    beq $s0, 1, outOne

    li $t2, 2      # Counter starting from 2

    loop:
    move $t3, $t1
    add $t1, $t1, $t0
    move $t0, $t3    

    addi $t2, $t2, 1    
    beq $t2, $s0, exit 
    j loop

    exit:
    li $v0, 4
    la $a0, newline
    syscall

    #print output prompt
    li $v0, 4
    la $a0, output_prompt
    syscall

    #print the nth Fibonacci number
    li $v0, 1
    move $a0, $t1
    syscall
	
    exit_call:
    #exit program
    li $v0, 10
    syscall

    # Handle N = 0 case
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
    j exit_call

    # Handle N = 1 case
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
    j exit_call
