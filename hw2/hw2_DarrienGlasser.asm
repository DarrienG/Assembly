.data
	inBuf:    .space    80
	bump: .space 80
	st_prompt:    .asciiz    "Enter a new input line. \n"
	newLine: .asciiz "\n"
 
.text
.globl main
 
main:
 
	la $a0, newLine
	li $v0, 4
	syscall
 
	jal getline 
 
	li $t1, 80 	# Max chars
	li $t0, 0 	# Current inBuf index
 
#get next char
next_char:
	lb $a3, inBuf($t0) 	# Load character from inBuf - offset by $t0
	beq $a3, 10, exit  	# Determine if end of input
	jal lin_srch 		
  
	addi $t0, $t0, 1 	# Increment inBuf index
 
	b   next_char
exit:
	la $a0, bump

	la $t8, ($a0)
	li $v0, 4
	syscall
 
	b main 
	li $v0, 10 
	syscall
 
     
getline:
 
	la $a0, st_prompt   # Asks for more input from user
	li $v0, 4
	syscall
 
	la $a0, inBuf 	    # Responsible for reading in input
	li $a1, 80
	li $v0, 8
	syscall
	jr $ra
 
 
lin_srch:
 	li $s6, 0 	   # Index of Tabchar (initially 0)

loop:
	lb $t4, Tabchar($s6)	# Load index of Tabchar into $t4
	beq $a3, $t4, ret  	# Compare inBuf byte and tabchar, if same, ret
	addi $s6, $s6, 8 	# Increment by 8 bytes to move to next char
	blt $s6, 608, loop 	

ret:
	lw $t4, Tabchar+4($s6) 	# Load weight of val into $t4
	addi $t4, $t4, 48 	# From int to ascii to make life easier
	beq $t4, '5', space
cont:
	sb $t4, bump($t0) 	
	jr $ra 
 
end:    move $a0, $t1
        li  $v0, 1
        syscall
        li  $v0, 10
        
space:
	sub $t4, $t4, 21	# Turns '5' into a blank character
	b cont
	              
.data

Tabchar:
    .word ' ', 5
    .word '#', 6
    .word '(', 4
    .word ')', 4
    .word '*', 3
    .word '+', 3
    .word ',', 4
    .word '-', 3
    .word '.', 4
    .word '/', 3
 
    .word '0', 1
    .word '1', 1
    .word '2', 1
    .word '3', 1
    .word '4', 1
    .word '5', 1
    .word '6', 1
    .word '7', 1
    .word '8', 1
    .word '9', 1
 
    .word ':', 4
 
    .word 'A', 2
    .word 'B', 2
    .word 'C', 2
    .word 'D', 2
    .word 'E', 2
    .word 'F', 2
    .word 'G', 2
    .word 'H', 2
    .word 'I', 2
    .word 'J', 2
    .word 'K', 2
    .word 'L', 2
    .word 'M', 2
    .word 'N', 2
    .word 'O', 2
    .word 'P', 2
    .word 'Q', 2
    .word 'R', 2
    .word 'S', 2
    .word 'T', 2
    .word 'U', 2
    .word 'V', 2
    .word 'W', 2
    .word 'X', 2
    .word 'Y', 2
    .word 'Z', 2
 
    .word 'a', 2
    .word 'b', 2
    .word 'c', 2
    .word 'd', 2
    .word 'e', 2
    .word 'f', 2
    .word 'g', 2
    .word 'h', 2
    .word 'i', 2
    .word 'j', 2
    .word 'k', 2
    .word 'l', 2
    .word 'm', 2
    .word 'n', 2
    .word 'o', 2
    .word 'p', 2
    .word 'q', 2
    .word 'r', 2
    .word 's', 2
    .word 't', 2
    .word 'u', 2
    .word 'v', 2
    .word 'w', 2
    .word 'x', 2
    .word 'y', 2
    .word 'z', 2
