    .data
prompt:     .asciiz "Enter a positive number: "
result_even:   .asciiz "The number is even."
result_odd:    .asciiz "The number is odd."

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

    # Check if the number is even or odd
    andi $t1, $t0, 1 
    beqz $t1, even    # If LSB is 0, the number is even
    j odd

even:
    # Print the result for even number
    li $v0, 4
    la $a0, result_even
    syscall
    j end

odd:
    # Print the result for odd number
    li $v0, 4
    la $a0, result_odd
    syscall

end:
    # Exit the program
    li $v0, 10
    syscall
