    .data
prompt:       .asciiz "Enter an integer: "
result_true:  .asciiz "The number is a perfect number."
result_false: .asciiz "The number is not a perfect number."

    .text
    .globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0 

    li $t1, 1  #divisor 1
    li $t2, 0  #sum 0

    divisor_loop:
        beq $t1, $t0, check_result  # if divisor equals the input exit the loop

        #check if $t1 is a divisor
        divu $t0, $t1
        mfhi $t3

        beqz $t3, add_to_sum

        j increment_divisor

    add_to_sum:
        add $t2, $t2, $t1 

    increment_divisor:
        addi $t1, $t1, 1
        j divisor_loop

    check_result:
    beq $t2, $t0, true
    j false

true:
    li $v0, 4
    la $a0, result_true
    syscall
    j end

false:
    li $v0, 4
    la $a0, result_false
    syscall

end:
    li $v0, 10
    syscall
