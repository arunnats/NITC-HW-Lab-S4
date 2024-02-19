    .data
prompt:       .asciiz "Enter an integer: "
result_true:  .asciiz "The number is a perfect number."
result_false: .asciiz "The number is not a perfect number."

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

    # Initialize variables for divisor loop and sum
    li $t1, 1  # Start with divisor 1
    li $t2, 0  # Initialize sum to 0

    divisor_loop:
        beq $t1, $t0, check_result  # If divisor equals the input, exit the loop

        # Check if $t1 is a divisor
        divu $t0, $t1
        mfhi $t3

        # If remainder is 0, $t1 is a divisor
        beqz $t3, add_to_sum

        j increment_divisor

    add_to_sum:
        add $t2, $t2, $t1  # Add divisor to the sum

    increment_divisor:
        addi $t1, $t1, 1  # Increment divisor
        j divisor_loop

    check_result:
    # Compare the sum with the original number
    beq $t2, $t0, perfect_true
    j perfect_false

perfect_true:
    # Print the result for a perfect number
    li $v0, 4
    la $a0, result_true
    syscall
    j end

perfect_false:
    # Print the result for not a perfect number
    li $v0, 4
    la $a0, result_false
    syscall

end:
    # Exit the program
    li $v0, 10
    syscall
