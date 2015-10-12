.data
# New
	TOKEN: .word 0,0
	tokArray: .word 0:60
	inBuf: .space 80
	retAddr: .word 0

#Old
	bump: .space 80
	st_prompt:    .asciiz    "Enter a new input line. \n"
	newLine: .asciiz "\n"

.text
#OLD
.globl main
 
main:

	# 1. Main function:
     	# 2. Read input line
     	# 3. call scanner driver
     	# 4. clear buffers
 
	jal newline 	# Reads in line from user
 
	li $t1, 80 	# Max chars
	li $t0, 0 	# Current inBuf index
 
#get next char
next_char:
	lb $a3, inBuf($t0) 	# Load character from inBuf - offset by $t0
	beq $a3, 10, exit   # Determine if end of input
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
 
 	la $a0, newLine     # Print out \n for cleaner input
	li $v0, 4
	syscall
	
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
	         



# NEW

# $t5: Get the next char
# T = char type
# $t5: global pointer of inBuf index     
# $s3: global index into TOKEN
# $a3: global index into array
dump:
     jal printline   
     jalr $v1, $s2
   
     sll $s0, $s0, 2
   #  // unfinished

newline:
     jal getline
     li $t5, 0
     li $s3, 0
     la $s1, Q0

driver:
    lw    $s2,($s1)
    jalr  $v1, $s2     # Save return address in $v1

    sll   $s0, $s0, 2    # T to byte offset
    add   $s1, $s1, $s0
    #sra   $s0, $s0, 2
    lw    $s0, ($s1)

    b    driver

ACT1:
     lb $a0, inBuf($t5)   
     jal lin_srch             # Return value stored in $s0
     addi $t5, $t5,  1        # Add 1 to counter register
     jr $v1                   # $t5++

# Save character to TOKEN
# adjust remaining token space
ACT2:
     # Check $s3 <= 7
     sw $a0, TOKEN($s3)
     addi $s3, $s3, 1
     jr $v1

# Not entirely sure what ACT3 does differently than ACT2
ACT3:
     sw $a0, TOKEN($s3)
     addi $s3, $s3, 1
     jr $v1

     # concatenate char in $a0 into TOKEN
     # increment $s3

ACT4:
     lw $t9, TOKEN($0)              # fully aware that you are accessing memory
     sw $t9, tokArray($a3)

     sw $t3, tokArray+4($a3)

     sw $a3, tokArray+8($a3)
     # copy 2nd word to tokArray
     # copy character type T ($a0) to tokArray+4
     # copy T ($a0) to tokArray+8
     # clear token

printline:

printTokArray:

clearInBuf:


clearTokArray:


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
    
    STAB:
Q0:     .word  ACT1
        .word  Q1   # T1
        .word  Q1   # T2
        .word  Q1   # T3
        .word  Q1   # T4
        .word  Q1   # T5
        .word  Q1   # T6
        .word  Q10  # T7

Q1:     .word  ACT2
        .word  Q2   # T1
        .word  Q5   # T2
        .word  Q3   # T3
        .word  Q3   # T4
        .word  Q0   # T5
        .word  Q4   # T6
        .word  Q10  # T7

Q2:     .word  ACT1
        .word  Q6   # T1
        .word  Q7   # T2
        .word  Q7   # T3
        .word  Q7   # T4
        .word  Q7   # T5
        .word  Q7   # T6
        .word  Q10  # T7

Q3:     .word  ACT4
        .word  Q0   # T1
        .word  Q0   # T2
        .word  Q0   # T3
        .word  Q0   # T4
        .word  Q0   # T5
        .word  Q0   # T6
        .word  Q10  # T7

Q4:     #.word  RETURN
        .word  Q4   # T1
        .word  Q4   # T2
        .word  Q4   # T3
        .word  Q4   # T4
        .word  Q4   # T5
        .word  Q4   # T6
        .word  Q10  # T7

Q5:     .word  ACT1
        .word  Q8   # T1
        .word  Q8   # T2
        .word  Q9   # T3
        .word  Q9   # T4
        .word  Q9   # T5
        .word  Q9   # T6
        .word  Q10  # T7

Q6:     .word  ACT3
        .word  Q2   # T1
        .word  Q2   # T2
        .word  Q2   # T3
        .word  Q2   # T4
        .word  Q2   # T5
        .word  Q2   # T6
        .word  Q10  # T7

Q7:     .word  ACT4
        .word  Q1   # T1
        .word  Q1   # T2
        .word  Q1   # T3
        .word  Q1   # T4
        .word  Q1   # T5
        .word  Q1   # T6
        .word  Q10  # T7

Q8:     .word  ACT3
        .word  Q5   # T1
        .word  Q5   # T2
        .word  Q5   # T3
        .word  Q5   # T4
        .word  Q5   # T5
        .word  Q5   # T6
        .word  Q10  # T7

Q9:     .word  ACT4
        .word  Q1  # T1
        .word  Q1  # T2
        .word  Q1  # T3
        .word  Q1  # T4
        .word  Q1  # T5
        .word  Q1  # T6
        .word  Q10 # T7

Q10:    #.word  ERROR 
        .word  Q4   # T1
        .word  Q4   # T2
        .word  Q4   # T3
        .word  Q4   # T4
        .word  Q4   # T5
        .word  Q4   # T6
        .word  Q4   # T7




