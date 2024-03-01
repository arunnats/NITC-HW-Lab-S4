	.data
prompt: .asciiz"Enter a number "
true: .asciiz"It is a palindrome: "
false: .asciiz"It is not a palindrome: "

	.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	move $t1, $t0 # make a copy
	
	li $t2, 0    
    	li $t3, 0    
    	
	loop:
	beqz $t0, check
	
	divu $t0, $t0, 10
        mfhi $t3
        
	mul $t2, $t2, 10
        add $t2, $t2, $t3
        
	j loop

check:
	 beq $t1, $t2, pal_true
    	 j pal_false
    	 
pal_true:
	li $v0, 4
	la $a0, true
	syscall
	j exit

pal_false:
	li $v0, 4
	la $a0, false
	syscall

exit:
	li $v0, 10
    	syscall
