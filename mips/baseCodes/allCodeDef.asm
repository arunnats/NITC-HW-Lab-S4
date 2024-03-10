#start with

.data
    
    #string predefined
    prompt:    .asciiz "This is how you rep a string "
    
    #string undefined
    theString:  .space 64  #allocates a string of length 63 bytes (characters) with the last byte being \0
    
    arr1: .space 100 #100 bytes 
    
    size: .word 5
    arr2: .word 12, -1, 8, 0, 6 #this stores each number as 32 bit "word"
 
 #start code with 
 
 .text
 
 	#input
 	
 	li $v0, 8
 	la  $a0, theString	#to take input of string
        li  $a1, 64		#a0 - adress of string, a1 - size of string
 	syscall  
 	
 	li $v0, 5
 	syscall		#to take input of int
 	move $t0, $v0
 	
 	li $v0, 6
 	syscall		#to take input of float
 	move $t0, $f0
 	
 	
 	#print
 	
 	li $v0, 4
 	la $a0, prompt	#to print string
 	syscall  
 	
 	li $v0, 1
 	la $a0, $t0	#to print int
 	syscall  
 	
 	li $v0, 12
 	la $f12, $t0	#to print float
 	syscall  
 	
 	#if
 	
 	bne $s1, $s2, L1 # branch if !( i == j )    essentially read this as if(i == j)
 	addi $s1, $s1, 1 # i++ 	 					       i++;
 	L1: 								    
 	addi $s2, $s2, -1 # j--
 	
 	#if else
 	
 	bne $s1, $s2, ELSE # branch if !( i == j )  
 	addi $s1, $s1, 1 # i++  
 	j NEXT # jump over else
 	ELSE: addi $s2, $s2, -1 # else j-- 
 	NEXT: add $s2, $s2, $s1 # j += i 
 	
 	#if else with compound AND
 	
 	bne $s1, $s2, ELSE # cond1: branch if !( i == j )  
 	bne $s1, $s3, ELSE # cond2: branch if !( i == k )  
 	addi $s1, $s1, 1 # if-body: i++  
 	j NEXT # jump over else
 	ELSE: addi $s2, $s2, -1 # else-body: j-- 
 	NEXT: add $s2, $s1, $s3 # j = i + k 
 	
 	#while loop
 	
 	L1:bge $s1, $s2, DONE # branch if ! ( i < j )  eq -> while ( i < j ) {
 	addi $s3, $s3, 1# k++					k++ ;
 	add $s1, $s1, $s1# i = i * 2				i = i * 2 ;
 	j L1# jump back to top of loop			      }
 	DONE:
 	
 	#working with arrays
 	
 	#loop with array:
 	
 	la $s0, size# initialize registers
 	lw $s1, 0($s0)  # set s1 to size
 	 
 	ori $s5, $0, 0 # set i to 0
 	la $s6, arr2 # $s6 is arr6
 	
 	L2: bge $s5, $s1, DONE 
 	
 	lw $s7, 0($s6) #s7 has arr2[i]
 	# logic
 	j UPDATE
 	
 	UPDATE:
 	addi $s5, $s5, 1 # i++
 	addi $s6, $s6, 4 # move array pointer
 	j L1 # repeat loop