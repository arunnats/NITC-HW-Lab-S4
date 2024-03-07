.data
    newline:    .asciiz "\n"
    prompt_i:   .asciiz "i"
    prompt_p:   .asciiz "p"
    prompt_s:   .asciiz "s"
    prompt_x:   .asciiz "x"
    prompt_e:   .asciiz "e"
    prompt_d:   .asciiz " "
    prompt_enter: .asciiz "\n"
    msg_rotations: .asciiz " rotations: "

.text
.globl main

    .data
struct_Node:
    .word 0          # key
    .word 0          # height
    .word 0          # l
    .word 0          # r

main:
    li $v0, 9            # Allocate memory for the root node
    li $a0, 16           # Size of Node structure in bytes
    syscall
    move $s0, $v0        # $s0 points to the root node

    li $t0, 0            # leftRot
    li $t1, 0            # rightRot

input_loop:
    li $v0, 12           # Read a character
    syscall
    beq $v0, 10, input_loop  # Skip newline characters

    beq $v0, 105, insert_case  # 'i'
    beq $v0, 112, print_case   # 'p'
    beq $v0, 115, calculate_case  # 's'
    beq $v0, 120, search_case   # 'x'
    beq $v0, 101, exit_case     # 'e'

    j input_loop

insert_case:
    li $v0, 5          # Read integer for insertion
    syscall
    move $a0, $v0      # $a0 contains the key
    move $a1, $s0      # $a1 contains the root address
    jal insertAVL
    b print_prompt

print_case:
    move $a0, $s0      # $a0 contains the root address
    jal printPreOrder
    j print_prompt

calculate_case:
    move $a0, $t0      # leftRot
    move $a1, $t1      # rightRot
    li $v0, 4
    la $a2, msg_rotations
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    j print_prompt

search_case:
    li $v0, 5          # Read integer for search
    syscall
    move $a0, $s0      # $a0 contains the root address
    move $a1, $v0      # $a1 contains the key
    jal search
    j print_prompt

exit_case:
    li $v0, 10         # Exit program
    syscall

print_prompt:
    li $v0, 4
    la $a0, newline
    syscall
    j input_loop

# Function to initialize a new Node
initializeNode:
    li $v0, 9            # Allocate memory for a new Node
    li $a0, 16           # Size of Node structure in bytes
    syscall
    jr $v0               # Return the address of the new Node

# Function to print a Node key in pre-order
printPreOrder:
    # $a0 contains the Node address
    lw $t0, 0($a0)       # Load key
    li $v0, 1
    move $a0, $t0
    syscall

    lw $t1, 8($a0)       # Load left child address
    beqz $t1, check_right_child  # Check if left child is null
    move $a0, $t1
    jal printPreOrder    # Recursively print left child

check_right_child:
    lw $t2, 12($a0)      # Load right child address
    beqz $t2, return_from_print  # Check if right child is null
    move $a0, $t2
    jal printPreOrder    # Recursively print right child

return_from_print:
    jr $ra               # Return to the caller

# Function to calculate the maximum of two integers
max:
    # $a0 contains the first integer
    # $a1 contains the second integer
    bge $a0, $a1, max_return_a0
    move $v0, $a1
    jr $ra

max_return_a0:
    move $v0, $a0
    jr $ra

# Function to calculate the height of a Node
height:
    # $a0 contains the Node address
    lw $t0, 8($a0)       # Load left child address
    lw $t1, 12($a0)      # Load right child address

    move $a0, $t0
    jal height           # Recursively calculate left child height
    move $t2, $v0

    move $a0, $t1
    jal height           # Recursively calculate right child height
    move $t3, $v0

    jal max              # Find the maximum of left and right child heights
    addi $v0, $v0, 1     # Add 1 to account for the current Node
    jr $ra               # Return to the caller

# Function to get the balance factor of a Node
getBalance:
    # $a0 contains the Node address
    lw $t0, 8($a0)       # Load left child address
    lw $t1, 12($a0)      # Load right child address

    move $a0, $t0
    jal height           # Recursively calculate left child height
    move $t2, $v0

    move $a0, $t1
    jal height           # Recursively calculate right child height
    move $t3, $v0

    sub $v0, $t2, $t3    # Subtract right child height from left child height
    jr $ra               # Return to the caller

# Function to perform a right rotation on a Node
rightRotate:
    # $a0 contains the Node address
    lw $t0, 0($a0)       # Load key
    lw $t1, 8($a0)       # Load left child address
    lw $t2, 12($a0)      # Load right child address

    move $a0, $t1        # $a0 now contains the left child address
    lw $t3, 12($a0)      # Load left child's right child address
    sw $t2, 12($a0)      # Set left child's right child to Node's right child
    move $t2, $a0        # $t2 now contains the new right child address

    move $a0, $t0        # $a0 now contains the Node address
    sw $t2, 8($a0)       # Set Node's left child to the new right child
    jr $t2               # Jump to the new right child address

# Function to perform a left rotation on a Node
leftRotate:
    # $a0 contains the Node address
    lw $t0, 0($a0)       # Load key
    lw $t1, 8($a0)       # Load left child address
    lw $t2, 12($a0)      # Load right child address

    move $a0, $t2        # $a0 now contains the right child address
    lw $t3, 8($a0)       # Load right child's left child address
    sw $t1, 8($a0)       # Set right child's left child to Node's left child
    move $t1, $a0        # $t1 now contains the new left child address

    move $a0, $t0        # $a0 now contains the Node address
    sw $t1, 12($a0)      # Set Node's right child to the new left child
    jr $t1               # Jump to the new left child address

# Function to insert a key into an AVL tree
insertAVL:
    # $a0 contains the key
    # $a1 contains the root address
    # $t0 contains leftRot
    # $t1 contains rightRot

    beqz $a1, create_node  # Check if the tree is empty

    lw $t2, 0($a1)        # Load key from the current Node
    lw $t3, 8($a1)        # Load left child address
    lw $t4, 12($a1)       # Load right child address

    blt $a0, $t2, insert_left  # Check if the key is less than the current Node's key

    beqz $t4, insert_right  # Check if the right child is null

    move $a1, $t4          # $a1 now contains the right child address
    jal insertAVL          # Recursively insert into the right subtree
    b check_balance

insert_right:
    # Right child is null, create a new Node
    move $a1, $t4          # $a1 contains the right child address
    jal initializeNode     # Allocate memory for a new Node
    move $t5, $v0          # $t5 contains the new Node address
    sw $t5, 12($a1)        # Set the right child to the new Node

    move $a1, $t5          # $a1 now contains the new Node address
    b check_balance

insert_left:
    # Left child is null, create a new Node
    move $a1, $t3          # $a1 contains the left child address
    jal initializeNode     # Allocate memory for a new Node
    move $t5, $v0          # $t5 contains the new Node address
    sw $t5, 8($a1)         # Set the left child to the new Node

    move $a1, $t5          # $a1 now contains the new Node address

check_balance:
    lw $t6, 8($a1)         # Load left child address
    lw $t7, 12($a1)        # Load right child address

    move $a0, $a1          # $a0 now contains the new Node address
    jal height             # Calculate the height of the new Node
    sw $v0, 4($a1)         # Set the height of the new Node

    move $a0, $t6          # $a0 now contains the left child address
    jal height             # Calculate the height of the left child
    move $t2, $v0          # $t2 contains the height of the left child

    move $a0, $t7          # $a0 now contains the right child address
    jal height             # Calculate the height of the right child
    move $t3, $v0          # $t3 contains the height of the right child

    sub $t4, $t2, $t3      # Subtract right child's height from left child's height

    sw $t2, 4($a1)         # Set the height of the left child in the new Node

    beqz $t6, update_height  # Check if the left child is null

    beqz $t7, update_height  # Check if the right child is null

    bgez $t4, rotate_left  # Check if the balance factor is greater than or equal to 0

    lw $a1, 12($a1)        # $a1 now contains the right child address
    jal rightRotate        # Perform a right rotation
    jr $v0

rotate_left:
    lw $a1, 8($a1)         # $a1 now contains the left child address
    jal leftRotate         # Perform a left rotation
    jr $v0

update_height:
    move $a1, $t5          # $a1 now contains the new Node address
    jal updateHeight      # Recursively update the height of ancestors
    jr $v0

create_node:
    move $a1, $s0          # $a1 contains the root address
    jal initializeNode     # Allocate memory for a new Node
    sw $v0, 0($a1)         # Set the root to the new Node
    jr $v0

# Function to update the height of ancestors during insertion
updateHeight:
    # $a1 contains the Node address
    # $t0 contains leftRot
    # $t1 contains rightRot

    lw $t2, 0($a1)         # Load key
    lw $t3, 8($a1)         # Load left child address
    lw $t4, 12($a1)        # Load right child address

    move $a0, $t3          # $a0 now contains the left child address
    jal height             # Calculate the height of the left child
    move $t5, $v0          # $t5 contains the height of the left child

    move $a0, $t4          # $a0 now contains the right child address
    jal height             # Calculate the height of the right child
    move $t6, $v0          # $t6 contains the height of the right child

    sub $t7, $t5, $t6      # Subtract right child's height from left child's height

    move $a0, $a1          # $a0 now contains the Node address
    jal height             # Calculate the height of the current Node
    sw $v0, 4($a1)         # Set the height of the current Node

    bgez $t7, update_height_left  # Check if the balance factor is greater than or equal to 0

    lw $a1, 12($a1)        # $a1 now contains the right child address
    jal rightRotate        # Perform a right rotation
    jr $v0

update_height_left:
    lw $a1, 8($a1)         # $a1 now contains the left child address
    jal leftRotate         # Perform a left rotation
    jr $v0

# Function to search for a key in an AVL tree
search:
    # $a0 contains the root address
    # $a1 contains the key

    beqz $a0, not_found    # Check if the tree is empty

    lw $t0, 0($a0)         # Load key from the current Node

    blt $a1, $t0, search_left  # Check if the key is less than the current Node's key
    bgt $a1, $t0, search_right  # Check if the key is greater than the current Node's key

    beq $a1, $t0, found      # Key is found

search_left:
    move $a0, $a0          # $a0 now contains the left child address
    jal search             # Recursively search in the left subtree
    jr $v0

search_right:
    move $a0, $a0          # $a0 now contains the right child address
    jal search             # Recursively search in the right subtree
    jr $v0

found:
    lw $t1, 0($a0)         # Load key from the current Node
    lw $t2, 8($a0)         # Load left child address
    lw $t3, 12($a0)        # Load right child address

    li $v0, 4
    move $a0, $t1
    syscall

    beqz $t2, found_right   # Check if the left child is null

    move $a0, $t2          # $a0 now contains the left child address
    jal printAncestors     # Print ancestors of the left child
    j end_search

found_right:
    beqz $t3, found_end     # Check if the right child is null

    move $a0, $t3          # $a0 now contains the right child address
    jal printAncestors     # Print ancestors of the right child
    j end_search

not_found:
    li $v0, 4
    la $a0, newline
    syscall
    jr $v0

found_end:
    li $v0, 4
    la $a0, newline
    syscall

end_search:
    jr $v0

# Function to print ancestors of a key in an AVL tree
printAncestors:
    # $a0 contains the Node address
    # $a1 contains the key

    beqz $a0, return_print  # Check if the Node is null

    lw $t0, 0($a0)         # Load key from the current Node
    lw $t1, 8($a0)         # Load left child address
    lw $t2, 12($a0)        # Load right child address

    blt $a1, $t0, printAncestors_left  # Check if the key is less than the current Node's key
    bgt $a1, $t0, printAncestors_right  # Check if the key is greater than the current Node's key

    move $a0, $a0          # $a0 now contains the left child address
    jal printAncestors     # Recursively print ancestors of the left child
    b return_print

printAncestors_left:
    move $a0, $t1          # $a0 now contains the left child address
    jal printAncestors     # Recursively print ancestors of the left child
    b return_print

printAncestors_right:
    move $a0, $t2          # $a0 now contains the right child address
    jal printAncestors     # Recursively print ancestors of the right child
    b return_print

return_print:
    lw $t3, 0($a0)         # Load key from the current Node
    li $v0, 4
    move $a0, $t3
    syscall
    jr $ra               # Return to the caller
