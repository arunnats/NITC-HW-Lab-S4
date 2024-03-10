    .data
prompt:       .asciiz "Enter a number: "
result_true:  .asciiz "The number is an Armstrong number."
result_false: .asciiz "The number is not an Armstrong number."

    .text
    .globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0 

    move $t1, $t0

    li $t2, 0  

    calculate_sum:
        beqz $t0, check_result  

        divu $t0, $t0, 10
        mfhi $t3

        mul $t4, $t3, $t3
        mul $t4, $t4, $t3
        add $t2, $t2, $t4

        j calculate_sum

    check_result:
    beq $t2, $t1, armstrong_true
    j armstrong_false

armstrong_true:
    li $v0, 4
    la $a0, result_true
    syscall
    j end

armstrong_false:
    li $v0, 4
    la $a0, result_false
    syscall

end:
    li $v0, 10
    syscall
