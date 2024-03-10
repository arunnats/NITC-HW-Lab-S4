.data
    newline:    .asciiz "\n"
    prompt_A:   .asciiz "Enter the value of A: "
    result_msg: .asciiz "Result of A + B: "
.text
    main:
        #prompt for A
        li $v0, 4
        la $a0, prompt_A
        syscall

        #read A
        li $v0, 5
        syscall
        move $s0, $v0  

	li $t0, 0

	# flip the bits of A
	nor $t1, $s0, $zero
	addi $t1, $t1, 1

        add $s1, $s0, $t1  # Result

        #display the result
        li $v0, 4
        la $a0, result_msg
        syscall

        #print the result
        li $v0, 1
        move $a0, $s1
        syscall
        
        li $v0, 10
        syscall
