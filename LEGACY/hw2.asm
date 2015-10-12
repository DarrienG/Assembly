.data
	inBuf:	.space	80
	st_prompt:	.asciiz	"Enter a new input line. \n"

.text

main:
	jal getline
	jal lin_search
	
	li $v0, 10
	syscall
	
getline: 
	la	$a0, st_prompt		# Prompt to enter a new line
	li	$v0, 4
	syscall

	la	$a0, inBuf		# read a new line
	li	$a1, 80	
	li	$v0, 8
	syscall
	jr $ra


#function linear search
#   $a0: char x
#   $s0: retval
lin_search:
	li	$t0,0		# I
	li	$s0, -1		# retval
loop:
	bge	$t0, 80, Ret
	sll	$t0, $t0, 3
	lw	$t9, Tabchar($t0)
	sra	$t0, $t0, 3
	bne	$t9, $a0, nextChar
	or	$s0,$t0,$0 #move $s0,$t0
	li	$s0, 1
	syscall
	b	Ret
nextChar:
	lb 	$a1, inBuf($t0) 	# Sequentially loads characters into $a1, one by one, overwriting the previous
	addi	$t0, $t0, 1
	b	loop
	
Ret:	jr	$ra


























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


