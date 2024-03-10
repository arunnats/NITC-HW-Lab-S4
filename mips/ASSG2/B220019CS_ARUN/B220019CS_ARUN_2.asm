	.data
prompt: .asciiz"Enter a number "
result: .asciiz"The factorial is: "

	.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 1
	
	loop:
		beqz $t0, end
		mul $t1, $t1, $t0
		subi $t0, $t0, 1 
		j loop
		
end:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
		
		li $v0, 10
    		syscall