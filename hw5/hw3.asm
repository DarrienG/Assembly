
	.data
TOKEN:	.word 	0x20202020,0x20202020
tokArray: .word	0:60
inBuf:	.space	80
retAddr: .word	0
st_prompt:	.asciiz	"Enter a new input line. \n"
new_line: 		.asciiz "\n"
cerr: 	.asciiz	"Error with input. Taking input and storing in tokArray.\n"
double_error:	.asciiz "Double Definition Error\n"

symTab:		.word	0:80
LOC:		.word   0x400
DEFN:		.word 	0
newStatus: 	.word	0
oldStatus:	.word 	0
symIndex:	.word 	0
isComma:	.word 	0
valVar:		.word 	0
curSymIndex:	.word	0

	.text

.globl main

main:
# We don't need a main, but I want it anyway

######################################################
#
# Main
#
#	read an input line
#	call scanner driver
#	clear buffers
#
#  $t5: global pointer of inBuf index
#  $s3: global index into TOKEN
#  $a3: global index into tokArray
#####################################################
	

newline:
	jal	getline
	li	$a3, 0
	li	$t5,0			# $t5: index to inBuf
	li	$s3,0			# $s3: index to TOKEN
	# State table driver
	la	$s1, Q0

driver:	lw	$s2, ($s1)
	jalr	$v1, $s2	# Save return addr in $v1

	abs	$s0, $s0
	sll	$s0, $s0, 2	# Multiply by 4 for word boundary
	add	$s1, $s1, $s0
	sra	$s0, $s0, 2 	# Shift back after operation is completed
	lw	$s1, 0($s1)
	b	driver

dump:	jal	printline
	#jal	printTokArray
	sw	$0, DEFN
	lb	$t8, tokArray($0)
	beq	$t8, '#', exit		# End on hash 
	
	
	li 	$t8, 0			# 'i' becomes zero


nextTok:
	addi	$t8, $t8, 12		# i+= 12 to move to next token
	lb	$t6, tokArray($t7)
	subi	$t7, $t7, 12		# Move back after checking
	bne	$t6, ':', operator	# Check to see if : there or not 
	
	lw	$t2, tokArray($t7)
	sw	$t2, TOKEN ($0)
	lw	$t2, tokArray+4($0)
	
	li	$t2, 1
	sw	$t2, DEFN		# set DEFN to 1
	la	$t3, VARIABLE
	jalr	$v1, $t3		# Storing return address in $v1
	addi	$t8, $t8, 12
	
	
operator:
	addi	$t8, $t8, 12
	li	$t5, 1
	sw	$t5, isComma		# isComma is set to true
	
chkVar:
	lb	$t6, tokArray+9($t8)

	beq	$t6, '5', dumpCont	# End on octothorpe 
	lw 	$t5, isComma		# if isComma is false, nextVar
	bne	$t5, 1, nextVar
	bne	$t6, '2', nextVar
	
	# TOKEN = tokArray[i][0]
	lw 	$t6, tokArray($t8)
	sw	$t6, TOKEN($0)
	lw	$t6, tokArray+4($t8)
	sw	$t6, TOKEN+4($0)
	
	li	$t2, 0
	sw	$t2, DEFN
	la	$t3, VARIABLE
	jalr	$v1, $t3
	

nextVar:
	lb	$t3, tokArray($t8)
	beq	$t3, 1 commaFound
	b	commaNotFound
	
commaFound:
	li	$t5, 1
	b	nextVarCont
commaNotFound:
	li	$t5, 0
	b 	nextVarCont

nextVarCont:
	sw	$t5, isComma
	addi	$t8, $t8, 12
	bc1f	chkVar
	 
dumpCont:
	# Clear buffer
	jal	cleanInBuf
	jal	cleanTokArray
	jal	printSymTab
	jal 	clearSymTab
	
	# LOC += 4
	lw	$t6, LOC
	addi	$t6, $t6, 4
	sw	$t6, LOC
	
	b 	newline
	
	# if clear symTab, need to reset curSymIndex to 0
	
exit:
	li $v0, 10
	syscall




####################### STATE ACTION ROUTINES #####################
#########################################
# ACT1:
#	$t5: Get next char
#	T = char type
########################################
ACT1: 
	lb	$a0, inBuf($t5)			# $a0: next char
	jal	lin_search			# $s0: T (char type)
	addi	$t5, $t5, 1			# $t5++
	jr	$v1
	
####################################
# ACT2:  save char to TOKEN
#	 adjust remainint token space
###################################
ACT2:
	move	$s3, $0
	sb	$a0, TOKEN($s3)
	addi	$s3, $s3, 1
	move	$t1, $s0
	jr 	$v1
	# else jr $v1 or T=7/return
	
	
######################################
ACT3:
	# check for $s3 <=7
	bgt 	$s3, 7, ACT4
	sb	$a0, TOKEN($s3)
	addi	$s3, $s3, 1
	jr 	$v1
	# concatenate char in #a0 into TOKEN
	# increment $s3
	
######################################
ACT4:
	lw	$t9, TOKEN($0)
	sw	$t9, tokArray($a3)
	
	addi	$a3, $a3, 4
	lw	$t9, TOKEN+4($0)
	sw	$t9, tokArray($a3)
	
	# Originally a0, revert if there are problems
	beq	$t1, 6, octothorpe
	
	b	a4action
	# copy 2nd word to tokArray+4
	# copy T+0x30 ($a0) to tokArray+8 (0x30 for printable ASCII)
	# clear TOKEN
	# update $s3 to point to the next entry in tokArray
	
octothorpe:
	li $t1, 5

a4action:
	addi	$t6, $t1, 48
	addi	$a3, $a3, 4
	sw 	$t6, tokArray($a3)

	lb	$t6, tokArray($a3)
	addi 	$a3, $a3, 1
	sb 	$t6, tokArray($a3)
	
	
	li	$t6, '\n'
	addi	$a3, $a3, 1
	sb	$t6, tokArray($a3)
	
	subi	$a3, $a3, 2
	li	$t6, '\t'
	sb	$t6, tokArray($a3)
	
	li	$t7, 0
	li	$t8 0x20
	

li	$t7, 0x20
li	$t8, 0	

a4loop:
	sb	$t7, TOKEN($t8)
	addi	$t8, $t8, 1
	blt	$t8, 8, a4loop		

a4update:
	addi	$a3, $a3, 4
	li	$s3, 0
	jr	$v1


# Prints out stuff 
printline:
	la $a0, inBuf
	li $v0, 4
	syscall
	jr $ra	

# Prints chars and types in neat table
printTokArray:
	li 	$t7, 0
	
ploop:
	la 	$a0, tokArray($t7)
	li	$v0, 4
	syscall
	addi	$t7, $t7, 12
	blt	$t7, 240, ploop
	jr	$ra

cleanInBuf:
	li $t7, 0
	li $s0, 0

cleanLoop:
	sb	$0, inBuf($t7)
	addi	$t7, $t7, 1
	ble	$t7, 80, cleanLoop
	li	$t0, 0
	jr 	$ra


cleanTokArray:
	li	 $t7, 0	# count
	li	 $t8, 60
	
	cleaningloop:	# Fills tokArrray with zeroes
		sb	$0, tokArray($t7)
		addi	$t7, $t7, 1
		blt 	$t7, $t8, cleaningloop
		jr	$ra

ERROR:
	la	$a0, cerr	# Still pretending this is c++, prints error message
	li	$v0, 4
	syscall
	
	jr	$v1	# Ignore error - move onto good input
	
RETURN:
	beq	$t1, 5, dump
	la	$t8, Q3		# Loading in address of Q3: 
	lw	$t8, ($t8)	# Load first byte of $t8 into $t8 (ACT4 called)
	jalr	$v1, $t8	# Make it so that we can return to RETURN and end everything
	b 	dump
	
	
	
getline: 
	
	la	$a0, new_line
	li	$v0, 4
	syscall
	
	la	$a0, st_prompt		# Prompt to enter a new line
	li	$v0, 4
	syscall

	la	$a0, inBuf		# read a new line
	li	$a1, 80	
	li	$v0, 8
	syscall
	
	# Load $s0, with delimiter, $t7 with final index in array
	# Load delimiter into final position in inBuf
	li 	$s4, 0
	li	$t8, '#'

getLoop:
	lb	$t7, inBuf($s4)
	bge	$s4, 79, getfin
	beq	$t7, '\0', getfin
	beq	$t7, '\n', getfin
	addi 	$s4, $s4, 1
	b getLoop
	
getfin:
	sb	$t8, inBuf($s4)
	jr 	$ra
	


#function linear search
#   $a0: char x
#   $s0: retval -- type of the letter in $a0
lin_search:
	li	$t0,0		# I
	li	$s0, 7		# retval
loop:
	bge	$t0, 72, Ret
	sll	$t0, $t0, 3
	lw	$t9, Tabchar($t0)
	sra	$t0, $t0, 3
	bne	$t9, $a0, nextChar
	
	sll	$t0, $t0, 3
	addi	$t0, $t0, 4
	lw	$t8, Tabchar($t0)
	move	$s0,$t8	 #move $s0,$t0
	b	Ret
	
nextChar:
	addi	$t0, $t0, 1
	b	loop
Ret:	jr	$ra


# NEW
#####################

VARIABLE:
	jal	LOOKUP
	lw	$t0, symIndex
	blt	$t0, 0, ifFirstOccurrence	# First occurrence of symbol
	b	ifReoccurring
	
ifFirstOccurrence:
	lw	$t2, DEFN
	ori	$s1, $t2, 0x4
	sw	$s1, newStatus
	jal	saveSymTab
	b	VARIABLEcont
	
ifReoccurring:
	lw	$s1, symTab+12($t0)	# oldStatus = symTab[symIndex][2]
	andi	$t0, $s1, 0x2		# oldStatys & 0x2
	andi	$t3, $s1, 0x1		# oldStatus & 0x1
	sll 	$t3, $t3, 1		# $t3 << 1
	
	sw 	$s1, oldStatus
	
	or	$s1, $t0, $t3		# newStatus = $t0 | $t3
	
	lw	$t0, symIndex
	lw	$t2, DEFN
	or	$s1, $s1, $t2		# newStatus = newStatus | DEFN
	sw	$s1, newStatus
	sw	$s1, symTab+12($t0)	# symTab[symIndex][2] = newStatus
	

VARIABLEcont:
	la	$s2, symACTS		# Load address of symACTS into $s2
	lw 	$s1, newStatus
	sll	$s1, $s1, 2		# Mult by size of word
	add	$s2, $s2, $s1		# Add offset to symACT address		

	lw	$s1, 0($s2)		# Load symAction into $s1
	jalr 	$s1			# Call symAction, then call retVal
	sw	$t3, valVar		# valVar = retVal
	jr 	$v1

LOOKUP:
	li	$t3, 0			# i = 0	 
	
LOOKUPLoop:	
	# Initially loading words from symTab and TOKEN
	lw	$t0, TOKEN($0)
	sll 	$t3, $t3, 4		# Mult by 16 (one element in STAB)
	lw	$t5, symTab($0)
	sra	$t3, $t3, 4
	bne	$t0, $t5, notEqual
	
	# Loading second words from TOKEN and symTab
	lw	$t0, TOKEN+4($t3)
	sll 	$t3, $t3, 4		# Mult by 16 (one element in STAB)
	lw	$t5, symTab+4($t3)
	sra	$t3, $t3, 4
	beq	$t0, $t5, LOOKUPSuccess
notEqual:	
	addi	$t3, $t3, 1		# ++i
	bge	$t3, 20, LOOKUPFail	# Iterate 20 times (all elements)
	b	LOOKUPLoop
LOOKUPSuccess:
	sw	$t3, symIndex		# Return symIndex
	jr	$ra
LOOKUPFail:
	li	$t3, -1			# Return invalid val (-1)
	sw	$t3, symIndex
	jr 	$ra
	
saveSymTab:
	lw	$t5, curSymIndex	
	lw	$t0, TOKEN($0)		# First word of TOKEN loaded 
	sw	$t0, symTab($t5)
	
	lw	$t0, TOKEN+4($0)	# Now loading in second word
	sw	$t0, symTab+4($t5)
	
	li	$t0, 0
	sw 	$t0, symTab+8($0)
	
	lw 	$t0, newStatus
	sw	$t0, symTab+12($0)
	sw	$t5, symIndex
	addi	$t5, $t5, 16
	sw	$t5, curSymIndex
	jr 	$ra


printSymTab:
	li	$t5, 0
	
printSymLoop:
	la 	$a0, symTab($t5)
	li	$v0, 4
	syscall
	
	#la	$a0, new_line
	
	addi	$t7, $t7, 12
	blt	$t7, 240, ploop
	jr	$ra


clearSymTab:
	li	$t0, 0
	sw	$t5, curSymIndex
	
symLoop:	# Fills tokArrray with zeroes

	bge	$t0, 320, endSymLoop
	li	$t6, 0
	sb	$t6, symTab($t0)
	addi	$t0, $t0, 1
	b symLoop

endSymLoop:
	jr	$ra
	
		
			
symACT0:
	lw	$t5, symIndex
	lw	$t0, LOC
	lw	$t3, symTab+8($t5)	# Loading VALUE into $t3, to be returned
	sw	$t0, symTab+8($t5)	# VALUE = LOC
	jr 	$ra
	
symACT1:
	lw	$t5, symIndex
	lw	$t0, LOC
	lw	$t3, symTab+8($t5)	# Loading VALUE into $t3, to be returned
	sw	$t0, symTab+8($t5)	# VALUE = LOC
	jr 	$ra

symACT2:
	lw	$t5, symIndex
	lw	$t3, symTab+8($t5)	# Still the same as previous
	jr 	$ra

symACT3:
	la	$a0, double_error
	li	$v0, 4			
	syscall				# Print out double definition error
	li	$t3, 0xFFFF		## Returning -1
	jr 	$ra

symACT4:
	lw	$t5, symIndex
	lw 	$t0, LOC
	sw	$t0, symTab+8($t5)
	li	$t3, 0xFFFF
	jr 	$ra

symACT5:
	lw	$t5, symIndex
	lw 	$t0, LOC
	sw	$t0, symTab+8($t5)
	li	$t3, 0	
	jr 	$ra



	.data
saveReg:	.word	0:3

		.text
hex2char:
		# save registers
		sw	$t0, saveReg($0)	# hex digit to process
		sw	$t1, saveReg+4($0)	# 4-bit mask
		sw	$t9, saveReg+8($0)

		# initialize registers
		li	$t1, 0x0000000f	# $t1: mask of 4 bits
		li	$t9, 3			# $t9: counter limit

nibble2char:
		and 	$t0, $a0, $t1		# $t0 = least significant 4 bits of $a0

		# convert 4-bit number to hex char
		bgt	$t0, 9, hex_alpha	# if ($t0 > 9) goto alpha
		# hex char '0' to '9'
		addi	$t0, $t0, 0x30		# convert to hex digit
		b	collect

hex_alpha:
		addi	$t0, $t0, -10		# subtract hex # "A"
		addi	$t0, $t0, 0x61		# convert to hex char, a..f

		# save converted hex char to $v0
collect:
		sll	$v0, $v0, 8		# make a room for a new hex char
		or	$v0, $v0, $t0		# collect the new hex char

		# loop counter bookkeeping
		srl	$a0, $a0, 4		# right shift $a0 for the next digit
		addi	$t9, $t9, -1		# $t9--
		bgez	$t9, nibble2char

		# restore registers
		sw	$t0, saveReg($0)
		sw	$t1, saveReg+4($0)
		sw	$t9, saveReg+8($0)
		jr	$ra



	.data

symACTS:	
	.word	symACT0
	.word	symACT1
	.word	symACT2
	.word	symACT3
	.word	symACT4
	.word	symACT5
	
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

Q4:     .word  RETURN
        .word  Q4   # T1
        .word  Q4   # T2
        .word  Q4   # T3
        .word  Q4   # T4
        .word  Q4   # T5
        .word  Q4   # T6
        .word  Q10 # T7

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

Q10:    .word  ERROR 
	.word  Q4  # T1
	.word  Q4  # T2
	.word  Q4  # T3
	.word  Q4  # T4
	.word  Q4  # T5
	.word  Q4  # T6
	.word  Q4  # T7
	
	
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
