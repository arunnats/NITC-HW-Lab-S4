.data
    prompt:        .asciiz "Enter a decimal number: "
    newline:       .asciiz "\n"
    binary_array:  .space 32   # Space for 32 bits

.text
    main:
        # Prompt for input
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        li $t1, 0
        li $t2, 32
        la $t3, binary_array
        li $t4, 2
        li $t5, 0

        # Convert decimal to binary and store in array
        convert_loop:
        bge $t1, $t2, convert_done

        divu $t0, $t4
        mfhi $t6
        mflo $t0

        addi $t6, $t6, '0'   # Convert to ASCII character
        sb $t6, 31($t3)

        addi $t1, $t1, 1
        subi $t3, $t3, 1
        j convert_loop

        convert_done:

        # Print the binary equivalent
        li $v0, 4
        la $a0, newline
        syscall

        li $v0, 4
        la $a0, binary_array
        syscall

        # Print a newline
        li $v0, 4
        la $a0, newline
        syscall

        # Exit program
        li $v0, 10
        syscall
