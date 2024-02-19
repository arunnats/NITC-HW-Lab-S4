    .data
prompt:      .asciiz "Enter a positive number: "
result_true: .asciiz "The number is a palindrome."
result_false: .asciiz "The number is not a palindrome."

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

    # Initialize variables for reversed number and remainder
    li $t2, 0     # Reversed number
    li $t3, 0     # Remainder

    # Reverse the number
    reverse_loop:
        beqz $t0, compare   # If $t0 is 0, exit the loop

        # Extract the last digit (remainder)
        divu $t0, $t0, 10
        mfhi $t3

        # Multiply the reversed number by 10 and add the remainder
        mul $t2, $t2, 10
        add $t2, $t2, $t3

        j reverse_loop

    compare:
    # Check if the original and reversed numbers are the same
    beq $t1, $t2, palindrome_true
    j palindrome_false

palindrome_true:
    # Print the result for a palindrome
    li $v0, 4
    la $a0, result_true
    syscall
    j end

palindrome_false:
    # Print the result for not a palindrome
    li $v0, 4
    la $a0, result_false
    syscall

end:
    # Exit the program
    li $v0, 10
    syscall
