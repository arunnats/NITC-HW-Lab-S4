    .data
prompt:      .asciiz "Enter a number: "
true:        .asciiz "Armstrong number.\n"
false:       .asciiz "Not armstrong number.\n"

    .text
main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    move $t1, $t0  # Make a cop

    li $t2, 0   

    loop:
    beqz $t0, check

    divu $t0, $t0, 10
    mfhi $t3

    mul $t4, $t3, $t3 
    mul $t4, $t4, $t3  
    add $t2, $t2, $t4  

    j loop

check:
    beq $t1, $t2, armstrong_true
    j armstrong_false

armstrong_true:
    li $v0, 4
    la $a0, true
    syscall
    j exit

armstrong_false:
    li $v0, 4
    la $a0, false
    syscall

exit:
    li $v0, 10
    syscall
