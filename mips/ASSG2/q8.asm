    .data
prompt_array:   .asciiz "Enter the array elements (space-separated): "
prompt_key:     .asciiz "Enter the key to search: "
result_found:   .asciiz "Element found at index: "
result_not_found: .asciiz "Element not found in the array."

    .text
    .globl main

main:
    # Prompt user for array elements
    li $v0, 4
    la $a0, prompt_array
    syscall

    # Read array elements
    li $v0, 8
    la $a0, array
    li $a1, 256  # Assuming a maximum of 256 elements
    syscall

    # Prompt user for the key to search
    li $v0, 4
    la $a0, prompt_key
    syscall

    # Read the key
    li $v0, 5
    syscall
    move $t0, $v0  # Store the key in $t0

    # Perform linear search
    li $t1, 0  # Initialize index to 0
    li $t2, -1  # Initialize flag to -1 (not found)

    linear_search_loop:
        beq $t1, $a1, end_linear_search  # If index equals array size, exit the loop

        lw $t3, array($t1)  # Load the element at the current index

        # Check if the current element is equal to the key
        beq $t3, $t0, element_found

        # Increment index and continue the loop
        addi $t1, $t1, 1
        j linear_search_loop

    element_found:
        move $t2, $t1  # Set the flag to the current index
        j end_linear_search

    end_linear_search:
    # Print the result
    beqz $t2, not_found
    li $v0, 4
    la $a0, result_found
    syscall

    # Print the index where the element was found
    li $v0, 1
    move $a0, $t2
    syscall
    j end

    not_found:
    li $v0, 4
    la $a0, result_not_found
    syscall

    end:
    # Exit the program
    li $v0, 10
    syscall

    .data
array: .space 256  # Array to store the input elements
