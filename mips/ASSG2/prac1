	.data
prompt: .asciiz"Enter a number "
result_even: .asciiz"Even "
result_odd: .asciiz"Odd  "

	.text

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	andi $t1, $t0, 1
	beqz $t1, even
	j odd

even:
	li $v0, 4
	la $a0, result_even
	syscall
	j exit
	
odd:
	li $v0, 4
	la $a0, result_odd
	syscall
	
exit:
	li $v0, 10
	syscall
	

	
