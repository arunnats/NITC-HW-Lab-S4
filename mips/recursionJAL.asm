# Program to compute the nth Fibonacci number and print the result
.text
.globl main

main:
	li	$a0, 5             # Load immediate value 5 into register $a0
	jal	fib               # Jump and link to the 'fib' function
	move 	$a0, $v0         # Move the result from $v0 to $a0
	jal	print_int         # Call 'print_int' to print the result
	jal	print_newline     # Call 'print_newline' to print a newline character
	j       exit             # Jump to exit to end the program

fib:	
    addiu	$sp, $sp, -12    # Decrement stack pointer to make room for 3 words
	sw	$ra, 0($sp)      # Save the return address on the stack
	sw	$s0, 4($sp)      # Save register $s0 on the stack
	sw	$s1, 8($sp)      # Save register $s1 on the stack
	
	addiu	$s0, $a0, 0      # Initialize $s0 with the value in $a0
	beq	$s0, $zero, done # If $s0 is 0, jump to 'done'
	addiu	$t0, $zero, 1    # Set $t0 to 1
	beq	$s0, $t0, done   # If $s0 is 1, jump to 'done'
	
	addiu	$a0, $s0, -1    # Decrement $s0, preparing argument for recursive call
	jal	fib              # Recursive call with fib(n-1)
	addiu	$s1, $v0, 0     # Store result of fib(n-1) in $s1
	addiu	$a0, $s0, -2    # Prepare argument for next recursive call
	jal	fib              # Recursive call with fib(n-2)
	addu	$v0, $v0, $s1   # Add results of fib(n-1) and fib(n-2)
	j	finish            # Jump to 'finish'
	
done:	
    addu	$v0, $zero, $s0  # Set $v0 to $s0 (base cases where n is 0 or 1)
	j	finish
	
finish: 
    lw	$s1, 8($sp)       # Restore $s1 from the stack
	lw	$s0, 4($sp)       # Restore $s0 from the stack
	lw	$ra, 0($sp)       # Restore $ra from the stack
	addiu	$sp, $sp, 12     # Adjust stack pointer back
	jr	$ra              # Return from function

print_int:
	move	$a0, $v0         # Move result into $a0, syscall argument for print
	li	$v0, 1            # Load system call code for printing an integer
	syscall                # Make system call
	jr	$ra               # Return from procedure

print_newline:
	li	$a0, '\n'         # Load newline character into $a0
	li	$v0, 11           # Load system call code for printing a character
	syscall                # Make system call
	jr	$ra               # Return from procedure

exit:
	li $v0, 10            # Load system call code for exit
	syscall                # Make system call to exit the program
