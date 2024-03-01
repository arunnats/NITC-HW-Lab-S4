.data
message:  .asciiz "Prime numbers between %d and %d are:\n"
prompt1:  .asciiz "Enter lower limit: "
prompt2:  .asciiz "Enter upper limit: "
result:   .asciiz "Total prime numbers found: %d\n"

.text
.globl main

main:
  # Print prompt for lower limit
  li $v0, 4        # syscall code for print string
  la $a0, prompt1  # load address of prompt string
  syscall

  # Read lower limit from user
  li $v0, 5        # syscall code for read integer
  syscall
  move $t0, $v0    # store lower limit in temporary register

  # Print prompt for upper limit
  li $v0, 4        # syscall code for print string
  la $a0, prompt2  # load address of prompt string
  syscall

  # Read upper limit from user
  li $v0, 5        # syscall code for read integer
  syscall
  move $t1, $v0    # store upper limit in temporary register

  li $s0, 0        # initialize prime count to 0

loop:
  # Check if current number is less than or equal to upper limit
  bgt $t0, $t1, done  # if not, jump to done

  # Check if current number is prime
  move $a0, $t0    # pass current number to isPrime function
  jal isPrime      # call isPrime function

  # Check if isPrime returned true (prime number found)
  beq $v0, 1, print_prime

  # Increment counter if prime number is found
  addi $s0, $s0, 1

print_prime:
  li $v0, 1         # syscall code for print integer
  move $a0, $t0     # pass current number to print function
  syscall

  # Print newline character
  li $v0, 4         # syscall code for print string
  la $a0, newline   # load address of newline string
  syscall

inc_t0:
  addi $t0, $t0, 1  # increment current number
  j loop            # jump back to loop

done:
  # Print total number of prime numbers found
  li $v0, 4         # syscall code for print string
  la $a0, result    # load address of result string
  syscall
  
  move $a0, $s0       # pass prime count to print function
  li $v0, 1         # syscall code for print integer
  syscall

  # Print newline character
  li $v0, 4         # syscall code for print string
  la $a0, newline   # load address of newline string
  syscall

  # Exit the program
  li $v0, 10        # syscall code for exit
  syscall

isPrime:
  # Logic to check if a number is prime
  # This is a simple implementation, replace it with your own logic
  li $v0, 0          # assume the number is not prime
  li $t2, 2          # start checking from 2
  blt $a0, $t2, prime  # if the number is less than 2, it's not prime
  move $t3, $a0       # store current number in temporary register
  div_loop:
    beq $t2, $t3, prime  # if divisor equals current number, it's prime
    div $t3, $t2      # divide current number by divisor
    mfhi $t4          # get remainder
    beqz $t4, not_prime  # if remainder is zero, not prime
    addi $t2, $t2, 1  # increment divisor
    j div_loop        # repeat division loop

prime:
  li $v0, 1          # return 1 to indicate prime
  jr $ra             # return to caller

not_prime:
  li $v0, 0          # return 0 to indicate not prime
  jr $ra             # return to caller

.data
newline: .asciiz "\n"
