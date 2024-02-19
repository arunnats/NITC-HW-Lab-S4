    .data
prompt:       .asciiz "Enter a number: "
result_true:  .asciiz "The number is an Armstrong number."
result_false: .asciiz "The number is not an Armstrong number."

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

    # Preserve the original number
    move $t1, $t0

    # Initialize variables for digit cube sum
    li $t2, 0  # Initialize sum to 0

    # Calculate the sum of the cubes of digits
    calculate_sum:
        beqz $t0, check_result  # If $t0 is 0, exit the loop

        # Extract the last digit
        divu $t0, $t0, 10
        mfhi $t3

        # Cube the digit and add to the sum
        mul $t4, $t3, $t3
        mul $t4, $t4, $t3
        add $t2, $t2, $t4

        j calculate_sum

    check_result:
    # Compare the sum with the original number
    beq $t2, $t1, armstrong_true
    j armstrong_false

armstrong_true:
    # Print the result for an Armstrong number
    li $v0, 4
    la $a0, result_true
    syscall
    j end

armstrong_false:
    # Print the result for not an Armstrong number
    li $v0, 4
    la $a0, result_false
    syscall

end:
    # Exit the program
    li $v0, 10
    syscall
