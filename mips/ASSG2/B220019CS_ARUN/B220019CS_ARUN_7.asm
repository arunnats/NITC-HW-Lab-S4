.data
    newline: .asciiz "\n"
    msg1: .asciiz "Enter the lower bound: "
    msg2: .asciiz "Enter the upper bound: "
    msg3: .asciiz "Prime numbers in the range: "

.text

main:
    li $v0, 4
    la $a0, msg1
    syscall
    li $v0, 5
    syscall
    move $s0, $v0  

    li $v0, 4
    la $a0, msg2
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 

    ori $s2, $0, 0  

    j loop

loop:
    beq $s0, $s1, exit  #exit loop when lower bound equals upper bound

    jal checkPrime

    beq $v0, $zero, not_prime
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    addi $s2, $s2, 1

not_prime:
    addi $s0, $s0, 1
    j loop

exit:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 10
    syscall

#function to check if a number is prime
checkPrime:
    li $t0, 2  
    j loopCheck

loopCheck:
    beq $t0, $s0, end_loop_yes
    rem $t3, $s0, $t0
    beq $t3, $zero, not_prime_flag
    addi $t0, $t0, 1
    j loopCheck

not_prime_flag:
    li $v0, 0 
    jr $ra

end_loop_yes:
    li $v0, 1
    jr $ra
