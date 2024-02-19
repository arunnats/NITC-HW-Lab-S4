    .data
prompt:     .asciiz "Enter a positive number: "
result:     .asciiz "The factorial is: "

    .text
    .globl main

main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the input
    li $v0, 5
    syscall
    move $t0, $v0  # Store the input in $t0

    # Initialize result to 1
    li $t1, 1

    # Compute factorial using a loop
    loop:
        beqz $t0, end   # If $t0 is 0, exit the loop
        mul $t1, $t1, $t0  # Multiply current result by $t0
        subi $t0, $t0, 1   # Decrement $t0
        j loop

    end:
    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    # Print the factorial result
    li $v0, 1
    move $a0, $t1
    syscall

    # Exit the program
    li $v0, 10
    syscall
