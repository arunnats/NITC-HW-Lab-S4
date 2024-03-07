.data
    newline:    .asciiz "\n"
    prompt1:    .asciiz "Enter the number of elements: "
    prompt2:    .asciiz "Enter element: "
    prompt3:    .asciiz "Array elements: "
    not_found:  .asciiz "Element not found.\n"
    found:      .asciiz "Element found at index "

    # Maximum array size
    max_size:   .word 100

    # Array to store elements
    array:      .space 400  # Adjust the size based on the maximum expected number of elements

.text
.globl main

main:
    # Display prompt for the number of elements
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read the number of elements
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 now contains the number of elements

    # Display prompt for each array element
    la $v0, 4
    la $a0, prompt2
    syscall

    # Initialize array index
    li $t0, 0

    # Loop to take input for each array element
input_loop:
    # Display prompt for array element
    li $v0, 4
    la $a0, prompt3
    syscall

    # Read array element
    li $v0, 5
    syscall
    sw $v0, array($t0)  # Store the element in the array

    # Increment array index
    addi $t0, $t0, 4

    # Decrement the number of elements
    addi $s0, $s0, -1
    bnez $s0, input_loop  # Continue the loop if more elements need to be input

    # Ask user for the element to search
    li $v0, 4
    la $a0, prompt2
    syscall

    # Read the key
    li $v0, 5
    syscall
    move $s1, $v0  # $s1 now contains the key to search

    # Linear search in the array
    li $t0, 0        # Reset array index to 0

search_loop:
    lw $t2, array($t0)  # Load the current element from the array

    # Check if the current element is equal to the key
    beq $t2, $s1, element_found

    # Increment array index
    addi $t0, $t0, 4

    # Check if the end of the array is reached
    bge $t0, max_size, element_not_found

    # Continue the search loop
    j search_loop

element_found:
    # Display the index where the key is found
    li $v0, 4
    la $a0, found
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    j exit_program

element_not_found:
    # Display a message if the key is not found
    li $v0, 4
    la $a0, not_found
    syscall

exit_program:
    # Exit program
    li $v0, 10
    syscall
