    .data
prompt:     .asciiz "Enter a 32-bit binary number:\n "
result:     .asciiz "The decimal equivalent is:\n "

    .text
    .globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8
    la $a0, buffer
    li $a1, 32 
    syscall
    move $t0, $a0  

    li $t1, 0      #control
    li $t2, 1      

    binary_to_decimal_loop:
        lb $t3, 0($t0)     #here we use the t0 position of hte input 
        beqz $t3, print_result  #if it's the null terminator end loop 

        sub $t3, $t3, '0'     #convert char to int
        mul $t3, $t3, $t2    
        add $t1, $t1, $t3     #add converted

        sll $t2, $t2, 1       #shift multiplier left
        addi $t0, $t0, 1      #use next position of input number 
        j binary_to_decimal_loop

    print_result:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 10
    syscall

    .data
buffer: .space 32 
