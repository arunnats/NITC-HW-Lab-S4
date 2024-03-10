#start with

.data
    
    #string predefined
    prompt:    .asciiz "This is how you rep a string "
    
    #string undefined
    theString:  .space 64  #allocates a strig of length 63 bytes (characters) with the last byte being \0