.data
    newline:    .asciiz "\n"
    prompt:     .asciiz "Enter a string: "
    theString:  .space 64
.text
    main:
        li $v0, 4
        la $a0, prompt
        syscall

        li  $v0, 8
        la  $a0, theString
        li  $a1, 64
        syscall

        la $t0, theString   #load the address of the string

    convert_characters_loop:
        lb $t1, 0($t0)      #load current char

        li $t2, 'A'
        blt $t1, $t2, check_lowercase
        li $t2, 'Z'
        bgt $t1, $t2, check_lowercase

        addi $t1, $t1, 32
        sb $t1, 0($t0)
        j continue_conversion

        check_lowercase:
        li $t2, 'a'
        blt $t1, $t2, continue_conversion
        li $t2, 'z'
        bgt $t1, $t2, continue_conversion

        #onvert lowercase to uppercase
        subi $t1, $t1, 32
        sb $t1, 0($t0)

        continue_conversion:
        addi $t0, $t0, 1     #Move to the next character
        bnez $t1, convert_characters_loop  # Cntinue the loop

        li $v0, 4
        la $a0, theString
        syscall

        li $v0, 10
        syscall
