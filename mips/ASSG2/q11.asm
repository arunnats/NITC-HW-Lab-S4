.data
    newline:    .asciiz "\n"
    prompt:     .asciiz "Enter a string: "
.text
    main:
        # Prompt for the string
        li $v0, 4
        la $a0, prompt
        syscall

        # Read the string
        li $v0, 8
        la $a0, 0  # Use register $a0 as a buffer
        li $a1, 255  # Assuming a buffer size of 255 characters, adjust as needed
        syscall

        # Process the string
        move $t0, $a0  # Address of the string

    process_loop:
        lb $t1, 0($t0)  # Load the current character
        beqz $t1, exit_process  # If the character is null, exit the loop

        # Check if the character is an uppercase letter
        li $t2, 'A'
        blt $t1, $t2, not_uppercase
        li $t2, 'Z'
        bgt $t1, $t2, not_uppercase

        # Convert uppercase to lowercase
        addi $t1, $t1, 32
        sb $t1, 0($t0)
        j continue_process

        not_uppercase:
        # Check if the character is a lowercase letter
        li $t2, 'a'
        blt $t1, $t2, continue_process
        li $t2, 'z'
        bgt $t1, $t2, continue_process

        # Convert lowercase to uppercase
        addi $t1, $t1, -32
        sb $t1, 0($t0)

        continue_process:
        addi $t0, $t0, 1  # Move to the next character
        j process_loop

    exit_process:
        # Display the modified string
        li $v0, 4
        la $a0, 0  # Use register $a0 as the address of the modified string
        syscall

        # Exit program
        li $v0, 10
        syscall
