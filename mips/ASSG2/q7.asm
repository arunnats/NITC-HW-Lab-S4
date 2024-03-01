    .data
prompt_start:   .asciiz "Enter the starting number of the range: "
prompt_end:     .asciiz "Enter the ending number of the range: "
result_prime:   .asciiz "Prime numbers in the range are: "
result_none:    .asciiz "No prime numbers in the given range."

    .text
    .globl main

main:
    # Prompt user for the starting number of the range
    li $v0, 4
    la $a0, prompt_start
    syscall

    # Read the starting number
    li $v0, 5
    syscall
    move $t0, $v0  # Store the starting number in $t0

    # Prompt user for the ending number of the range
    li $v0, 4
    la $a0, prompt_end
    syscall

    # Read the ending number
    li $v0, 5
    syscall
    move $t1, $v0  # Store the ending number in $t1

    # Print the prime numbers in the given range
    li $v0, 4
    la $a0, result_prime
    syscall

    # Initialize variables for checking prime numbers
    move $t2, $t0  # Copy the starting number to $t2
    jal check_primes  # Jump to the check_primes subroutine

    # Print a new line before exiting
    li $v0, 4
    la $a0, newline
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Subroutine to check and print prime numbers in a range
check_primes:
    check_prime_loop:
        # Check if $t2 is prime
        jal is_prime  # Jump to the is_prime subroutine

        # If $v0 is 1 (prime), print the number
        beqz $v0, not_prime

        # Print the prime number
        li $v0, 1
        move $a0, $t2
        syscall

        # Print a space after each prime number
        li $v0, 4
        la $a0, space
        syscall

        not_prime:
        addi $t2, $t2, 1  # Increment $t2
        blt $t2, $t1, check_prime_loop  # If $t2 is less than $t1, continue the loop

    ret:
    jr $ra  # Return to the calling routine

# Subroutine to check if a number is prime
is_prime:
    # Preserve $ra
    sw $ra, 0($sp)
    sub $sp, $sp, 4

    # Initialize variables for divisor loop
    li $t3, 2  # Start with divisor 2

    divisor_loop:
        beq $t3, $t2, prime_result  # If divisor equals the number, exit the loop

        # Check if $t3 is a divisor
        divu $t2, $t3
        mfhi $t4

        # If remainder is 0, $t2 is not prime
        beqz $t4, not_prime_result

        j increment_divisor

    not_prime_result:
        li $v0, 0  # Set $v0 to 0 (not prime)
        j end_is_prime

    increment_divisor:
        addi $t3, $t3, 1  # Increment divisor
        j divisor_loop

    prime_result:
        li $v0, 1  # Set $v0 to 1 (prime)

    end_is_prime:
    # Restore $ra
    lw $ra, 0($sp)
    add $sp, $sp, 4

    jr $ra  # Return to the calling routine

    .data
space:    .asciiz " "
newline:  .asciiz "\n"
