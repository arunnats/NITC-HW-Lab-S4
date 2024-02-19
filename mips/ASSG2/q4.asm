    .data
prompt:     .asciiz "Enter a 32-bit binary number: "
result:     .asciiz "The decimal equivalent is: "

    .text
    .globl main

main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the input
    li $v0, 8
    la $a0, buffer
    li $a1, 32  # Read 32 characters
    syscall
    move $t0, $a0  # Store the input in $t0

    # Convert binary to decimal
    li $t1, 0        # Initialize result to 0
    li $t2, 1        # Initialize multiplier to 1

    binary_to_decimal_loop:
        lb $t3, 0($t0)      # Load a character from the binary string
        beqz $t3, print_result  # If it's the null terminator, print the result

        sub $t3, $t3, '0'     # Convert ASCII character to integer (0 or 1)
        mul $t3, $t3, $t2     # Multiply the digit by the current multiplier
        add $t1, $t1, $t3     # Add the result to the running total

        sll $t2, $t2, 1       # Shift the multiplier left by 1 bit
        addi $t0, $t0, 1      # Move to the next character
        j binary_to_decimal_loop

    print_result:
    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    # Print the decimal equivalent
    li $v0, 1
    move $a0, $t1
    syscall

    # Exit the program
    li $v0, 10
    syscall

    .data
buffer: .space 32  # Buffer to store the binary input
